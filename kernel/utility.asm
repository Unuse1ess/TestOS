;------------------------------------------------------------------
;							History
;	Version 0.1:
;		2020/11/14 Created by MYM.
;------------------------------------------------------------------

[bits 32]
[section .text]

global _memset_w

; Prototype: void* memset_w(word* dst, word value, unsigned word_cnt);
; &dst:			ebp + 0x8
; &value:		ebp + 0xc
; &word_cnt:	ebp + 0x10

_memset_w:
	push ebp
	mov ebp, esp

	mov eax, [ebp + 0xc]
	mov ecx, [ebp + 0x10]
	mov edi, [ebp + 0x8]

	cld							; edi += 2 automatically
	rep stosw					; Write the value in ax to [edi]

	mov eax, [ebp + 0x8]		; Return value

	leave
	ret