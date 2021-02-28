;-------------------------------------------------------
;						History
;	Version 0.1:
;		2021/21/26 Created by MYM.
;-------------------------------------------------------

[bits 32]


global _init_fpu
global _set_ts
global _save_fpu_context
global _restore_fpu_context

_init_fpu:
	mov eax, cr0

	or eax, 0xA		; Set MP (bit 1) and TS (bit 3)
	and eax, ~0x24	; Clear EM (bit 2) and NE (bit 5)
	mov cr0, eax

	mov eax, cr4
	bts eax, 9		; Set OSFXSR (bit 9) to support SSE
	mov cr4, eax
	
	ret

_set_ts:
	mov eax, cr0
	bts eax, 3
	mov cr0, eax

	ret

_save_fpu_context:
	mov eax, [esp + 4]
	fxsave [eax]
	fninit			; fxsave does not initialize the FPU
	ret

_restore_fpu_context:
	mov eax, [esp + 4]
	fxrstor [eax]
	ret

