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
[extern _get_desc_base_addr]
[extern _tss]

; Defined in task.c
[extern _rdy_thread]

global _start_user_thread



; Prototype: void start_user_thread();
; Return to a prepared user stack, using rdy_thread.
_start_user_thread:
	; Make it able to return to kernel stack
	; tss.esp0 = rdy_thread + sizeof(THREAD_CONTEXT);
	mov eax, [_rdy_thread]

	lldt [eax + LDTR]

	add eax, SIZE_OF_THREAD_CONTEXT
	mov [_tss + TSS_ESP0], eax

	mov esp, [_rdy_thread]

	; Restore context
	pop gs
	pop fs
	pop es
	pop ds
	popad

	add esp, 8

	iretd

