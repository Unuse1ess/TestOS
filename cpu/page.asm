;-------------------------------------------------------
;						History
;	Version 0.1:
;		2020/11/19 Created by MYM.
;-------------------------------------------------------

[bits 32]
[extern _page_dir_table]

global _start_paging
global _get_page_fault_addr

_start_paging:
	; Set cr3, which is page directory base register
	mov eax, _page_dir_table
	mov cr3, eax

	mov eax, cr0
	or eax, 0x80000000		; Set PG bit
	mov cr0, eax

	ret

_get_page_fault_addr:
	mov eax, cr2
	ret