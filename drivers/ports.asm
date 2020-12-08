

global _port_byte_in
global _port_byte_out
global _port_word_in
global _port_word_out
global _port_dword_in
global _port_dword_out

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