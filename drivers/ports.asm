;---------------------------------------------------------
;						History
;	Version 0.1:
;		2020/11/13 Created by MYM.
;		2020/12/10 Supported I/O by dword and by a memory block.
;---------------------------------------------------------

global _port_byte_in
global _port_byte_out
global _port_word_in
global _port_word_out
global _port_dword_in
global _port_dword_out
global _port_buffer_in
global _port_buffer_out

; Prototype: byte port_byte_in(word port)
_port_byte_in:
	mov dx, [esp + 4]
	in al, dx
	movzx eax, al
	
	ret

; Prototype: void port_byte_out(word port, byte data)
_port_byte_out:
	mov dx, [esp + 4]
	mov al, [esp + 8]
	out dx, al

	ret

; Prototype: word port_word_in(word port)
_port_word_in:
	mov dx, [esp + 4]
	in ax, dx
	movzx eax, ax

	ret

; Prototype: void port_word_out(word port, word data)
_port_word_out:
	mov dx, [esp + 4]
	mov ax, [esp + 8]
	out dx, ax

	ret
	
; Prototype: dword port_dword_in(word port)
_port_dword_in:
	mov dx, [esp + 4]
	in eax, dx

	ret
	
; Prototype: void port_dword_out(word port, dword data)
_port_dword_out:
	mov dx, [esp + 4]
	mov eax, [esp + 8]
	out dx, ax

	ret
	
; Prototype: void* port_buffer_in(word port, void* buffer, unsigned size)
_port_buffer_in:
	mov eax, [esp + 8]
	mov dx, [esp + 4]
	mov edi, eax
	mov ecx, [esp + 12]
	shr ecx, 2

	rep insd

	ret
	
; Prototype: void port_buffer_out(word port, void* buffer, unsigned size)
_port_buffer_out:
	mov dx, [esp + 4]
	mov esi, [esp + 8]
	mov ecx, [esp + 12]
	shr ecx, 2				; 4-byte aligned

	rep outsd

	ret

