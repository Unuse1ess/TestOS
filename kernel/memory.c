/*--------------------------------------------------------------
 *						Time: 2020/11/19
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/19 created by MYM.
 *
 *-------------------------------------------------------------*/

#define MEMORY_C

#include "types.h"
#include "../cpu/seg.h"
#include "task.h"
#include "../cpu/page.h"
#include "../cpu/isr.h"
#include "../drivers/screen.h"
#include "../include/stdlib.h"
#include "../include/function.h"


 /* The OS use 0x000000~0x100000, using 0x100 pages.
  * These pages should be mapped as F(x) = x.
  */
#define NUM_OF_KERNEL_PAGE			0x100

#define MAX_NUM_OF_PAGE_TABLE		0x400		/* Maximum 1024 page tables */
#define MAX_SIZE_OF_PAGE_DIR_TABLE	0x1000		/* Page directory table's size is 4KB */

#define NUM_OF_PAGE					0x400		/* 1024 pages in a page table */
#define SIZE_OF_PAGE_TABLE			0x1000		/* Page table's size is 4KB */


  /* Page table is defined at .PG_TBL section,
   * which is at 0x10000.
   */
__attribute__((section(".PG_TBL")))
PAGE_ITEM page_dir_table[MAX_NUM_OF_PAGE_TABLE];
__attribute__((section(".PG_TBL")))
PAGE_ITEM page_table[MAX_NUM_OF_PAGE_TABLE][NUM_OF_PAGE];

struct __dummy
{};

/* Initialization of kernel pages and enter page mode. */
void init_page()
{
	int i, j;
	dword page_base = 0;

	page_dir_table[0].attribute = PAGE_SYSTEM | PAGE_PRESENT;
	page_dir_table[0].base_low = LOWORD(page_table) >> 12;
	page_dir_table[0].base_high = HIWORD(page_table);
	page_dir_table[0].avl = 0;

	for (i = 0; i < NUM_OF_KERNEL_PAGE; i++)
	{
		page_table[0][i].attribute = PAGE_SYSTEM | PAGE_PRESENT;
		page_table[0][i].base_low = LOWORD(page_base) >> 12;
		page_table[0][i].base_high = HIWORD(page_base);
		/* System pages are default allocated */
		page_table[0][i].allocated = PAGE_ALLOCATED;

		page_base += SIZE_OF_PAGE;
	}
}

dword get_phys_addr(dword virt_addr)
{
	dword dir_index, page_index, offset;

	dir_index = GET_PAGE_TABLE_INDEX(virt_addr);
	page_index = GET_PAGE_INDEX(virt_addr);
	offset = GET_OFFSET_IN_PAGE(virt_addr);

	return MAKEDWORD(page_table[dir_index][page_index].base_low << 12, page_table[dir_index][page_index].base_high) + offset;
}

void* page_allocate(unsigned size, unsigned flags)
{
	return NULL;
}


void page_free(void* ptr)
{

}


/* Handler of fault general protection */
void CALLBACK gp_handler(THREAD_CONTEXT* regs)
{
	UNUSED(regs);
	kprintf("General protection!\neip: 0x%X\nErr code: %d\n", regs->eip, regs->err_code);
}

/* Handler of page fault */
void CALLBACK pf_handler(THREAD_CONTEXT* regs)
{
	UNUSED(regs);

	dword addr;

	kprintf("Page fault!\n");
	addr = get_page_fault_addr();
	kprintf("Address: 0x%p\n", addr);

	while (1);
}
