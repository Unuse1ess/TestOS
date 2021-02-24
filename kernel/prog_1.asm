[bits 32]

global _test_A
global _@1

_test_A:
	push ebp
	mov ebp, esp

	mov ebx, 0x400000 + string - _test_A

	push ebx
@1:
	mov eax, 1
	int 0x80

	call _print_screen
	jmp @1

_print_screen:
	mov eax, 0
	int 0x80
	ret
	
string: db 'a', 0, 0, 0
