[bits 32]

global _test_B
global _string

_test_B:
	push ebp
	mov ebp, esp

	push 0x400000 + _string - _test_B
@1:
	mov eax, 1
	int 0x80

	call _print_screen
	jmp @1

_print_screen:
	mov eax, 0
	int 0x80
	ret

_string: db 'B', 0
