;------------------------------------------------------------------
;							History
;	Version 0.1:
;		2020/11/21 Created by MYM.
;------------------------------------------------------------------


; To start, or resume a thread, first we should construct a
; a structure that contains the context of the execution flow,
; which has general-purposed registers, segment registers and
; interrupt number and error code, for convinience when handling
; interrupts (see task.h).


%include "kernel/sconst.inc"

[bits 32]

; Defined in gdt.c
[extern _tss]

; Defined in task.c
[extern _rdy_thread]

; Defined in math.asm
[extern _set_ts]

global _switch_to

; Prototype: void switch_to(THREAD* next);
_switch_to:
	mov ecx, [esp + 4]

; Save kernel thread's context
	push ebp
	push ebx
	push esi
	push edi

; Save stack pointer at TCB
	mov eax, [_rdy_thread]
	mov [eax + KERNEL_ESP], esp

; Change the interrupt number to decide if it needs to send EOI
;	mov eax, [eax + INT_NUM]
;	mov [ecx + INT_NUM], eax

; Change the page directory table
	mov eax, [ecx + T_CR3REG]
	mov cr3, eax

; Switch to target kernel thread
	mov esp, [ecx + KERNEL_ESP]
	lea eax, [ecx + SIZE_OF_THREAD_CONTEXT]
	mov [_tss + TSS_ESP0], eax

; Change current running thread
	mov [_rdy_thread], ecx

; Set the TS bit in cr0
	call _set_ts

; Restore kernel context
	pop edi
	pop esi
	pop ebx
	pop ebp

	ret

