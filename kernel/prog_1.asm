[bits 32]

global _test_A

_test_lock equ 0x800100

_test_A:
;	mov eax, 2
;	int 0x80
;	jmp $

	mov esi, 1

	push ebp
	mov ebp, esp

	xor ecx, ecx

	mov edx, 0x10101010
	movd xmm0, edx
	movd xmm1, ecx
	movd xmm2, ecx
	
	mov edx, 0x10101010
	movd xmm3, edx
	
	fld dword [0x400000 + half - _test_A]
	fldpi
	fmul st0, st1
	fldpi
	
	sub esp, 20
	push 0x400000 + string - _test_A
@1:
;	push _test_lock
;	call _lock
;	add esp, 4

	paddusb xmm0, xmm3

	movd dword [esp + 4], xmm0
	movd dword [esp + 8], xmm1
	movd dword [esp + 12], xmm2
	
	fmul st0, st1
	fst dword [esp + 16]
	
;	mov eax, [0x800000]

	call delay

;	add eax, 1
;	mov [0x800000], eax
;	push _test_lock
;	call _unlock
;	add esp, 4

;	push dword [0x800000]
;	push 0x400000 + string - _test_A
	call _print_screen
;	add esp, 8

	jmp @1

_print_screen:
	mov eax, 0
	int 0x80
	ret
	
_lock:
	mov eax, 1

locked:
	mov ecx, [esp + 4]
	cmp dword [ecx], 0
	jz get_lock

	pause
	jmp locked

get_lock:
	xchg eax, [ecx]
	test eax, eax
	jnz locked
	
	ret

_unlock:
	xor eax, eax
	mov ecx, [esp + 4]
	xchg eax, [ecx]
	dec eax
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

;string: db "Prog1: var = %d", 10, 0
string: db "Prog1: xmm0 = 0x%x; xmm1 = 0x%x; xmm2 = 0x%x; result = 0x%x", 10, 0
half: dd 0.5
