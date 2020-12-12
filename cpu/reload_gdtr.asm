;-------------------------------------------------------
;						History
;	Version 0.1:
;		2020/11/16 Created by MYM.
;-------------------------------------------------------

[bits 32]
[section .text]

global _reload_gdtr

; Prototype: void reload_gdt(GDTR* p);
; &p: ebp + 8
_reload_gdtr:
	push ebp
	mov ebp, esp

	sub esp, 8
	sgdt [esp]

	mov ebx, [ebp + 8]

	xor ecx, ecx
	mov cx, [esp]			; Notice that size of field limit in gdtr is 2 bytes
	inc ecx					; (ecx + 1) / 4
	shr ecx, 2

	mov esi, [esp + 2]		; Origin base address of gdtr
	mov edi, [ebx + 2]		; New base address of gdtr

	mov [esp + 2], edi		; Update the new address and limit.
	mov dx, [ebx]
	mov [esp], dx

	lgdt [esp]				; Load new gdtr

	; Copy the origin GDT to a new place
	; specified by gdt_base. It is safe
	; because the segment descriptors in
	; GDT are not changed.
	cld
	rep movsd

	leave
	ret