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

#include "../cpu/page.h"
#include "../cpu/isr.h"
#include "../drivers/screen.h"
#include "../kernel/types.h"
#include "../include/stdlib.h"
#include "../include/function.h"


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
	page_dir_table[0].full = PAGE_TABLE_NOT_FULL;

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

/* Handler of fault general protection */
void CALLBACK gp_handler(THREAD_CONTEXT regs)
{
	UNUSED(regs);

	kprintf("General protection!\n");
}

/* Handler of page fault */
void CALLBACK pf_handler(THREAD_CONTEXT regs)
{
	UNUSED(regs);

	dword addr;

	kprintf("Page fault!\n");
	addr = get_page_fault_addr();
	kprintf("Address: 0x%p\n", addr);

	while (1);
}

void* page_allocate(unsigned size, unsigned flags)
{
	return NULL;
}


void page_free(void* ptr)
{

}
