%include "kernel/sconst.inc"

[bits 32]

; Defined in tss.c
[extern _tss]

; Defined in proc.c
[extern _proc_table]
[extern _proc_offset]


global _restart

	
; Prototype: void restart()
_restart:
	mov esp, [_proc_table]
	add esp, [_proc_offset]

	lldt [esp + LDTR]
	lea eax, [esp + STACK_TOP]
	mov [_tss + TSS_ESP0], eax
	
	pop gs
	pop fs
	pop es
	pop ds
	popad

	add esp, 12

	iretd