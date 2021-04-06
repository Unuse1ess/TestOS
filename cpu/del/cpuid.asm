;-------------------------------------------------------
;						History
;	Version 0.1:
;		2021/3/3 Created by MYM.
;-------------------------------------------------------

[bits 32]


; Prototype: void cpuid(dword eax, dword ecx, void* buffer);
_cpuid:
	push ebp
	mov ebp, esp

	push ebx
	push esi

	mov eax, [ebp + 8]
	mov ecx, [ebp + 12]
	cpuid

	mov esi, [ebp + 16]
	mov [esi], eax
	mov [esi + 4], ebx
	mov [esi + 8], ecx
	mov [esi + 12], edx

	pop esi
	pop ebx

	leave
	ret
