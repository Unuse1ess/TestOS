[bits 32]

global _test_C

_test_lock equ 0x800100

_test_C:
	mov eax, 2
	int 0x80

	mov esi, 3

	push ebp
	mov ebp, esp

	xor ecx, ecx
	
	mov edx, 0x30303030
	movd xmm2, edx
	movd xmm1, ecx
	movd xmm0, ecx

	mov edx, 0x10101010
	movd xmm3, edx
	
	fldln2
	fldln2

	sub esp, 20
	push 0x400000 + string - _test_C
@1:

	paddusw xmm2, xmm3

	movd dword [esp + 4], xmm0
	movd dword [esp + 8], xmm1
	movd dword [esp + 12], xmm2
	
	fdiv st0, st1
	fst dword [esp + 16]

	call delay

	call _print_screen

	jmp @1
	
_print_screen:
	mov eax, 0
	int 0x80
	ret

delay:
	push ecx
	xor ecx, ecx
@3:
	inc ecx
	cmp ecx, 0x1000000
	jne @3

	pop ecx
	ret
	
string: db "Prog3: xmm0 = 0x%x; xmm1 = 0x%x; xmm2 = 0x%x; result = 0x%x", 10, 0
