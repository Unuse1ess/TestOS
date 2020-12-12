;----------------------------------------------------------------
;							History
;	Version 0.1:
;		2020/11/14 Created by MYM.
;----------------------------------------------------------------

[bits 32]
[section .text]

global _memcpy

; Prototype: void* memcpy(void* dst, void* src, unsigned size);
; &dst: ebp + 0x8
; &src: ebp + 0xc
; &size: ebp + 0x10
_memcpy:
	push ebp
	mov ebp, esp

	; Return value
	mov eax, [ebp + 0x8]

	; Get the remainder of size divided by 4
	mov ebx, [ebp + 0x10]
	and ebx, 0x00000003
	
	; Get the result of size divided by 4
	mov ecx, [ebp + 0x10]
	shr ecx, 2

	mov esi, [ebp + 0xc]
	mov edi, eax

	cld
	rep movsd
	
	mov ecx, ebx
	rep movsb

	leave
	ret


