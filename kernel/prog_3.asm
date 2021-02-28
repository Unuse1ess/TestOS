[bits 32]

global _test_C

_test_C:
	push ebp
	mov ebp, esp

	xor ecx, ecx

	fldln2
	fldln2

	push 0
	push 0x400000 + string - _test_C
@1:
	inc ecx
	cmp ecx, 0xf000000
	jne @1
	xor ecx, ecx
	
	fmul st0, st1
	fst dword [esp + 4]
	
	call _print_screen
	jmp @1
	
_print_screen:
	mov eax, 0
	int 0x80
	ret

string: db "Prog3: 0x%x", 10, 0
