[bits 32]
[extern _kprint]

global _print_screen
global _sys_print_screen

; Prototype: void print_screen(char* str);
_print_screen:
	mov eax, 0
	int 0x80
	ret

; Prototype: void sys_print_screen(char** arg);
_sys_print_screen:
	mov eax, [esp + 4]
	mov eax, [eax]
	push eax
	call _kprint
	add esp, 4

	ret
	