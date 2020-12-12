;-----------------------------------------------------------------------------
;									History
;	Version 0.1:
;		2020/11/26 Created by MYM.
;-----------------------------------------------------------------------------

KERNEL_CS equ 8

[bits 32]

[extern _apm_data]

global _shutdown
global _stand_by
global _reset
global _suspend
global _apm_jump_stub


; Prototype: int suspend();
_suspend:
	push ebp
	mov ebp, esp
	
	mov eax, 0x5307
	mov ebx, 1
	mov ecx, 2

	call KERNEL_CS:_apm_jump_stub
	
	leave
	ret

; Prototype: int stand_by();
_stand_by:
	push ebp
	mov ebp, esp

	mov eax, 0x5307
	mov ebx, 1
	mov ecx, 1

	; Use far call to save value of cs
	call KERNEL_CS:_apm_jump_stub

	leave
	ret

; Prototype: void shutdown();
_shutdown:
	push ebp
	mov ebp, esp
	
	mov eax, 0x5307
	mov ebx, 1			; Device ID for all power device
	mov ecx, 3

	; No 'int 0x15' here because it is in protect mode.

	call KERNEL_CS:_apm_jump_stub

	; If these codes run, APM may not supports this function.
	; Leave the error handler to C codes.

	leave
	ret

; Prototype: void reset();
_reset:
	push ebp
	mov ebp, esp

	WaitRdy:
	in al, 0x64			; Get the state of 8042
	test al, 2
	jnz WaitRdy

	mov al, 0xfe		; pin = 0 is reset
	out 0x64, al			; Reset

	leave
	ret
	
; This instruction is modified by C codes
; in order to select a correct call gate and
; make it acts like 'int 0x15'.
; The size of instruction 'callf' is 7 bytes.
_apm_jump_stub:
	jmp 0:0