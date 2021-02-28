[bits 32]
[extern _kvprintf]

global _vprintf
global _sys_vprintf


_vprintf:
	mov eax, 0
	int 0x80
	ret

;	kernel stack
;--------------------
;	...
;-------------------- <= esp (in CPU)
;	return address
;--------------------
;	user_esp + 4
;--------------------
;	...
;--------------------

;	user stack
;--------------------
;	...
;-------------------- <= user_esp
;	return address
;-------------------- <= user_esp + 4 (eax)
;	fmt
;--------------------
;	args
;--------------------
;	...
;--------------------

_sys_vprintf:
	mov eax, [esp + 4]		; [esp + 4] points to parameters,
	mov ecx, [eax]			; and the first parameter is pointer to string.
	add eax, 4

	push eax
	push ecx
	call _kvprintf
	add esp, 8

	ret
