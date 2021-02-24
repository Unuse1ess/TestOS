[bits 32]

global _test_C

_test_C:
	push ebp
	mov ebp, esp

	push 0x400000 + string - _test_C
@1:
	mov eax, 1
	int 0x80

	call _print_screen
	jmp @1
	
_print_screen:
	mov eax, 0
	int 0x80
	ret

string: db 'C', 0
