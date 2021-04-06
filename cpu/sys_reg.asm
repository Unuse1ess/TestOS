;-------------------------------------------------------
;						History
;	Version 0.1:
;		2021/4/5 Reconstructed by MYM. The content is
;		originated from cpuid.asm, load_ldtr.asm,
;		load_idtr.asm, load_tr.asm, reload_gdt.asm,
;		msr.asm.
;-------------------------------------------------------


global _cpuid
global _load_ldtr
global _load_idtr
global _load_tr
global _reload_gdtr
global _read_msr
global _write_msr

[bits 32]

; void cpuid(dword eax, dword ecx, void* buffer);
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

	
; void load_ldtr(word sel);
_load_ldtr:
	lldt [esp + 4]
	ret

	
; void load_idtr(word size, dword* idt);
_load_idtr:
	shl dword [esp + 4], 16
	lidt [esp + 6]
	ret

	
; void load_tr(word tr);
_load_tr:
	ltr [esp + 4]
	ret
	
; void reload_gdt(GDTR* p);
; &p: ebp + 8
_reload_gdtr:
	push ebp
	mov ebp, esp

	sub esp, 8
	sgdt [esp]

	mov ebx, [ebp + 8]

	xor ecx, ecx
	mov cx, [esp]			; Notice that size of field limit in gdtr is 2 bytes
	inc ecx					; (ecx + 1) / 4
	shr ecx, 2

	mov esi, [esp + 2]		; Origin base address of gdtr
	mov edi, [ebx + 2]		; New base address of gdtr

	mov [esp + 2], edi		; Update the new address and limit.
	mov dx, [ebx]
	mov [esp], dx

	; Copy the origin GDT to a new place
	; specified by gdt_base. It is safe
	; because the segment descriptors in
	; GDT are not changed.
	cld
	rep movsd
	
	lgdt [esp]				; Load new gdtr

	leave
	ret
	
; void read_msr(uint32 address, uint64* value);
_read_msr:
	mov ecx, [esp + 4]
	rdmsr
	mov ecx, [esp + 8]
	mov [ecx], eax
	mov [ecx + 4], edx
	ret


; void write_msr(uint32 address, uint64 value);
_write_msr:
	mov ecx, [esp + 4]
	mov eax, [esp + 8]
	mov edx, [esp + 12]
	wrmsr
	ret
