[bits 32]
[extern _page_dir_table]

global _start_paging

_start_paging:
	; Set cr3, which is page directory base register
	mov eax, _page_dir_table
	mov cr3, eax

	mov eax, cr0
	or eax, 0x80000000		; Set PG bit
	mov cr0, eax

	ret