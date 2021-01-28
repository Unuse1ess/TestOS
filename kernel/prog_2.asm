[bits 32]

global _test_B
global _string

_test_B:
	push ebp
	mov ebp, esp

	push _string
@1:
	call _print_screen
	jmp @1

_print_screen:
	mov eax, 0
	int 0x80
	ret

_string: db 'B ', 0
