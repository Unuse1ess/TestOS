[bits 32]
[section .text]

global _reload_gdt

; Prototype: void reload_gdt(GDT gdt_base);
; &gdt_base: ebp + 0x8
_reload_gdt:
	push ebp
	mov ebp, esp

	sub esp, 0x8
	sgdt [esp]

	xor ecx, ecx
	mov cx, [esp]			; Notice that size of field limit in gdtr is 2 bytes
	inc ecx					; (ecx + 1) / 4
	shr ecx, 2

	mov esi, [esp + 2]		; Origin base address of gdtr
	mov edi, [ebp + 0x8]	; New base address of gdtr

	mov [esp + 2], edi		; Update the new address and
	lgdt [esp]				; load new gdtr

	; Copy the origin GDT to a new place
	; specified by gdt_base. It is safe
	; because the segment descriptors in
	; GDT are not changed.
	cld
	rep movsd

	leave
	ret