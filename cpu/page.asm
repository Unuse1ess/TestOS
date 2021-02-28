;-------------------------------------------------------
;						History
;	Version 0.1:
;		2020/11/19 Created by MYM.
;-------------------------------------------------------

[bits 32]

global _start_paging
global _get_page_fault_addr
global _set_cr3
global _get_cr3
global _invalidate_page


; Prototype: void start_paging();
_start_paging:
; This function assume that PE and cr3 is set.

; Enable global pages
	mov eax, cr4
	bts eax, 7				; Set PGE (bit 7)
	; TODO: Enable PAE (bit 5)

	mov cr4, eax

	mov eax, cr0
	bts eax, 31				; Set PG (bit 31), enable paging
	
; Maximize the performance of processor by caching

	and eax, ~0x60000000	; Clear CD (bit 30) and NW (bit 29)
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

; Prototype: void* get_cr3();
_get_cr3:
	mov eax, cr3
	and eax, 0xFFFFF000
	ret

; Prototype: void _invalidate_page(void* v_addr);
_invalidate_page:
	mov eax, [esp + 4]
	invlpg [eax]
	ret

