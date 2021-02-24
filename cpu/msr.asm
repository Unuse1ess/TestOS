;-------------------------------------------------------
;						History
;	Version 0.1:
;		2021/2/22 Created by MYM. Offered interfaces of
;		reading model specified registers.
;-------------------------------------------------------

global _read_msr
global _write_msr

; Prototype: void read_msr(uint32 address, uint64* value);
_read_msr:
	mov ecx, [esp + 4]
	rdmsr
	mov ecx, [esp + 8]
	mov [ecx], eax
	mov [ecx + 4], edx
	ret

; Prototype: void write_msr(uint32 address, uint32 low, uint32 high);
_write_msr:
	mov ecx, [esp + 4]
	mov eax, [esp + 8]
	mov edx, [esp + 12]
	wrmsr
	ret
