[bits 32]

global _get_tick

; Prototype: dword get_tick();
_get_tick:
	mov eax, 1
	int 0x80
	ret