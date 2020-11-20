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
{
};

/* Initialization of page and enter page mode */
void init_page()
{
	int i, j;
	dword pg_tbl_base = (dword)page_table;
	dword page_base = 0;
	byte attr = PAGE_SYSTEM | PAGE_PRESENT;

	/* First page table and corresponding pages are used by OS.
	 * The rest of page tables and corresponding pages are used by application.
	 */
	for (i = 0; i < NUM_OF_PAGE_TABLE; i++)
	{
		page_dir_table[i].attribute = attr;
		page_dir_table[i].base_low = LOWORD(pg_tbl_base) >> 12;
		page_dir_table[i].base_high = HIWORD(pg_tbl_base);

		for (j = 0; j < NUM_OF_PAGE; j++)
		{
			page_table[i][j].attribute = attr;
			page_table[i][j].base_low = LOWORD(page_base) >> 12;
			page_table[i][j].base_high = HIWORD(page_base);
			/* System pages are default allocated */
			page_table[i][j].allocated = attr & PAGE_APPLICATION;

			page_base += SIZE_OF_PAGE;
		}

		pg_tbl_base += SIZE_OF_PAGE_TABLE;
		attr = PAGE_APPLICATION | PAGE_PRESENT;
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
void CALLBACK gp_handler(INTERRUPT_STACK_REGS regs)
{
	UNUSED(regs);

	kprintf("General protection!\n");
}

/* Handler of page fault */
void CALLBACK page_fault_handler(INTERRUPT_STACK_REGS regs)
{
	UNUSED(regs);

	kprintf("Page fault!\n");
}

void* page_allocate(unsigned size, unsigned flags)
{
	
}

void* page_free(void* ptr)
{

}