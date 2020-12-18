;------------------------------------------------------------------
;							History
;	Version 0.1:
;		2020/11/21 Created by MYM.
;------------------------------------------------------------------


; To start, or resume a process, first we should construct a
; a structure that contains the context of the execution flow,
; which has general-purposed registers, segment registers and
; interrupt number and error code, for convinience when handling
; interrupts (see task.h).
; We also need a structure that contains information of a process,
; therefore we need a process table. So far we need LDTR, LDT, TR
; and TSS.

%include "kernel/sconst.inc"

[bits 32]

; Defined in gdt.c
[extern _get_descriptor_base_addr]

global _start_task
	
; Prototype: void start_task(TASK* rdy_task);
; &proc: ebp + 8
_start_task:
	push ebp
	mov ebp, esp

	mov eax, [ebp + 8]					; Address in task table, pointing to the prepared process.
										; And eax is stack top.

	xor ebx, ebx
	mov bx, [eax + TR]					; New TR

	str ecx								; Current TR
	cmp cx, bx
	je task_not_changed					; Avoid loading a busy TSS, leading to #GP.
	
	; Change the TR
	ltr [eax + TR]

task_not_changed:
	; Get the base address of TSS
	push ebx							; eax = get_descriptor_base_addr(ebx);
	call _get_descriptor_base_addr		; No need to 'add esp, 4'

	mov esp, [ebp + 8]

	lldt [esp + LDTR]

	; cr3

	lea ecx, [esp + SIZE_OF_STACK]		; Make esp points to correct task structure
	mov [eax + TSS_ESP0], ecx			; when return to kernel.
	
	pop gs
	pop fs
	pop es
	pop ds
	popad

	add esp, 8

	iretd