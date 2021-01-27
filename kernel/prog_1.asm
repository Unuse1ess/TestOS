[bits 32]

global _test_A

_test_A:
	push ebp
	mov ebp, esp

	push string
@1:
	call _print_screen
	jmp @1

_print_screen:
	mov eax, 0
	int 0x80
	ret

string: db 'A ', 0
