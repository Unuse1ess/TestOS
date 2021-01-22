;-------------------------------------------------------
;						History
;	Version 0.1:
;		2020/11/19 Created by MYM.
;-------------------------------------------------------

[bits 32]

global _start_paging
global _get_page_fault_addr
global _set_cr3


; Prototype: void start_paging();
_start_paging:
; This function assume that PE and cr3 is set.
	mov eax, cr0
	or eax, 0x80000000		; Set PG bit
	mov cr0, eax
	ret
	
; Prototype: dword get_page_fault_addr();
_get_page_fault_addr:
	mov eax, cr2
	ret
	
; Prototype: void set_cr3(void* pdt_base);
_set_cr3:
	mov eax, [esp + 4]
	mov cr3, eax
	ret
