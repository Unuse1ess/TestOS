;-------------------------------------------------------
;						History
;	Version 0.1:
;		2021/1/22 Created by MYM.
;-------------------------------------------------------

[bits 32]

global _memset

; Prototype: void* memset(void* _dst, int value, unsigned size);
_memset:
	mov ecx, [esp + 12]
	shr ecx, 2

	mov edi, [esp + 4]

	xor eax, eax
	mov al, [esp + 8]
	mov ah, al
	push eax
	shl eax, 16
	or eax, [esp]

	rep stosd

	mov ecx, [esp + 16]
	and ecx, 3

	rep stosb

	add esp, 4
	mov eax, [esp + 4]
	ret