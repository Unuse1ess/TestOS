/*--------------------------------------------------------------
 *							History
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

/*					Physical memory distribution
 *		+-------------------------------------------------+
 *		|	0x0 ~ 0x4FF				IVT & BIOS data		  |
 *		+-------------------------------------------------+
 *		|	0x500 ~ 0x5FF			APM data			  |
 *		+-------------------------------------------------+
 *		|	0x600 ~ 0x7FF			Memory block data	  |	
 *		+-------------------------------------------------+
 *		|	0x800 ~ 0x8FF			?VBE data			  |
 *		+-------------------------------------------------+
 *		|	0x900 ~ 0xFFF			Free memory			  |
 *		+-------------------------------------------------+
 *		|	0x1000 ~ 0x7BFF			Kernel code & data	  |
 *		+-------------------------------------------------+
 *		|	0x7C00 ~ 0x7DFF			Boot sector			  |
 *		+-------------------------------------------------+
 *		|	0x7E00 ~ 0x7FFF			Real mode stack		  |	512 bytes is enough
 *		+-------------------------------------------------+
 *		|	0x10000 ~ 0x10FFF		?Page directory table |
 *		+-------------------------------------------------+
 *		|	0x11000 ~ 0x12FFF		?Page table			  |
 *		+-------------------------------------------------+
 *		|	0x13000 ~ 0x8FFFF		Free memory			  |
 *		+-------------------------------------------------+
 *		|	0x90000 ~ 0x9FBFF		Kernel stack		  |	About 64KB is enough
 *		+-------------------------------------------------+
 *		|	0x9FC00 ~ 0x9FFFF		Extended BIOS data	  |
 *		+-------------------------------------------------+
 *		|	0xA0000 ~ 0xBFFFF		Video memory		  |
 *		+-------------------------------------------------+
 *		|	0xC0000 ~ 0xFFFFF		BIOS & ROM			  |
 *		+-------------------------------------------------+
 *		|					Free memory					  |
 *		+-------------------------------------------------+
 * 
 *	?: Not sure yet.
 * 
 *	It is not the linear address, nor the virtual memory space!
 */


 /* The OS use 0x000000~0x100000, using 0x100 pages.
  * These pages should be mapped as F(x) = x.
  */
#define NUM_OF_KERNEL_PAGE			0x100

#define MAX_NUM_OF_PAGE_TABLE		0x400		/* Maximum 1024 page tables */
#define MAX_SIZE_OF_PAGE_DIR_TABLE	0x1000		/* Page directory table's size is 4KB */

#define NUM_OF_PAGE					0x400		/* 1024 pages in a page table */
#define SIZE_OF_PAGE_TABLE			0x1000		/* Page table's size is 4KB */

#define NUM_OF_PAGE_TABLE			2


#define ADDR_RANGE_AVAILABLE		1			/* 1 indicates this memory range is available for OS,
													and other values indicate reserved.*/

#pragma pack(push, 1)

/* Strucutre of memory information */
typedef struct
{
	qword base_addr;
	qword length;
	dword type;
}MEMORY_BLOCK_INFO;

#pragma pack(pop)


  /* Page table is defined at .PG_TBL section,
   * which is at 0x20000.
   */
__attribute__((section(".PG_TBL")))
PAGE_ITEM page_dir_table[MAX_NUM_OF_PAGE_TABLE];
__attribute__((section(".PG_TBL")))
PAGE_ITEM page_table[NUM_OF_PAGE_TABLE][NUM_OF_PAGE];

/* Memory information is stored at 0x6200 */
__attribute__((section(".mem")))
MEMORY_BLOCK_INFO mem_block_info[20];		/* Temporarily support 20 memory block info */


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
