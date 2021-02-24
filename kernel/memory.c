/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/19 created by MYM.
 *
 *-------------------------------------------------------------*/

#define MEMORY_C

#include "types.h"
#include "../cpu/seg.h"
#include "../cpu/page.h"
#include "task.h"
#include "../cpu/isr.h"
#include "../drivers/screen.h"
#include "../include/stdlib.h"
#include "../include/function.h"
#include "spin_lock.h"
#include "debug.h"

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
  *		|	0x900 ~ 0xFFF			?					  |
  *		+-------------------------------------------------+
  *		|	0x1000 ~ 0x7BFF			Kernel code & data	  |
  *		+-------------------------------------------------+
  *		|	0x7C00 ~ 0x7DFF			Boot sector			  |
  *		+-------------------------------------------------+
  *		|	0x7E00 ~ 0x7FFF			Real mode stack		  |	512 bytes is enough
  *		+-------------------------------------------------+
  *		|	0x8000 ~ 0x8FFF			Kernel PDT			  |
  *		+-------------------------------------------------+
  *		|	0x9000 ~ 0x9FFF			Kernel PTE			  |
  *		+-------------------------------------------------+
  *		|	0xA000 ~ 0x29FFF		Memory map			  |
  *		+-------------------------------------------------+
  *		|	0x2A000 ~ 0x9CFFF		Free memory			  |
  *		+-------------------------------------------------+
  *		|	0x9D000 ~ 0x9EFFF		Kernel stack(PE = 1)  | 8KB is enough
  *		|							Boot sector (PE = 0)  | 
  *		+-------------------------------------------------+
  *		|	0x9F000 ~ 0x9FBFF		Not used			  |
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

  /* Notice that an item in page directory table can manage at most 4MB memory. */

  /* There are 3 states for a virtual page:
   *	0) Not allocated (0 in page table)
   *	1) Allocated at physical memory (PAGE_PRESENT)
   *	2) Allocated at hard-disk
   */

#define SIZE_OF_MEM_BMP				0x20000

#define NUM_OF_PAGE_TABLE			0x400			/* Maximum 1024 page tables */
#define SIZE_OF_PAGE_DIR_TABLE		0x1000			/* Page directory table's size is 4KB */

#define NUM_OF_PAGE					0x400		/* 1024 pages in a page table */
#define SIZE_OF_PAGE_TABLE			0x1000		/* Page table's size is 4KB */

   /*
	* According to the physical memory distribution,
	* page frame #0 ~ #0x29 are used.
	*/
#define NUM_OF_USED_PAGES			0x2A		/* Pages that are used in advance */


	/* A bit is set when a corresponding page is used. */
#define PAGE_FREE					0
#define PAGE_USED					1

/* Kernel is mapped to 0xC0000000 of virtual address space */
#define KERNEL_VA_BASE				0xC0000000


/* Information for managing memory */

/*
 * Physical memory that is to be managed.
 * Every bit in this bitmap represents whether a physical page is used.
 */
__attribute__((section(".mmap")))
static byte memory_bitmap[SIZE_OF_MEM_BMP];

/* Kernel's PDT and PTE, and PTE is shared by all the user programs. */
__attribute__((section(".PG_TBL")))
PAGE_ITEM kernel_page_dir_table[1024];
__attribute__((section(".PG_TBL")))
static PAGE_ITEM kernel_page_table[1024];

/* Memory information is stored at */
__attribute__((section(".mem")))
static const MEMORY_BLOCK_INFO mem_block_info[20];		/* Temporarily support 20 memory block info */


struct __dummy
{
};


void set_page(dword page_num, dword attr);
dword is_page_free(dword page_num);


void init_memory()
{
	dword i, j, end_byte, end_bit;
	const MEMORY_BLOCK_INFO* p = mem_block_info;

	/*
	 * Initialize the memory bitmap.
	 * Physical memory that OS cannot use
	 * (where type != 1) is marked as used pages.
	 */

	 /* First treat all pages are used */
	memset(memory_bitmap, 0xFF, SIZE_OF_MEM_BMP);

	/* Then free the unused pages below 1MB */
	for (i = 0x2A; i <= 0x9C; i++)
		set_page(i, PAGE_FREE);
	/* And free available memory above 1MB according to memory block info */
	while (p->type != 0)
	{
		if (p->base_addr < 0x100000)
			goto _continue;
		if (p->type == 1)
		{
			/* Page as unit, represented as a bit */
			i = (dword)p->base_addr >> 12;
			end_byte = i + (dword)p->length >> 12;

			end_bit = end_byte & 7;		/* Equivalent to ... % 8 but faster */
			end_byte >>= 3;
			j = i & 7;					/* i is start byte and j is start bit in start byte */
			i >>= 3;
			/* High (8 - j) bits is set to 0 */
			if (j)
			{
				memory_bitmap[i] &= ((1 << (byte)j) - 1);
				i++;
			}
			/* Low nbit bits is set to 0 */
			if (end_bit)
			{
				memory_bitmap[end_byte] &= ~((1 << (byte)end_bit) - 1);
				/* No need to 'end_byte--;' because end_bit is behind end_byte. */
			}
			memset(&memory_bitmap[i], 0, end_byte - i);
		}

	_continue:
		p++;
	}

	/*
	 * Initialize kernel directory page table.
	 * Map as F(x) = x where 0 <= x < 1MB.
	 * Notice that all PDT have attribute 'PAGE_USER',
	 * even it is used by kernel.
	 */
	memset(kernel_page_dir_table, 0, SIZE_OF_PAGE_DIR_TABLE);
	kernel_page_dir_table[0] = MAKE_PDT_ITEM(kernel_page_table, PAGE_USER | PAGE_PRESENT | PAGE_GLOBAL);

	/* Point to itself to make it able to modify itself.
	 * Therefore, it can be accessed through virtual address 0xFFFFF000.
	 */
	kernel_page_dir_table[1023] = MAKE_PDT_ITEM(kernel_page_dir_table, PAGE_USER | PAGE_PRESENT);

	/* Initialize kernel page table */
	memset(kernel_page_table, 0, SIZE_OF_PAGE_TABLE);
	for (i = 0; i < NUM_OF_USED_PAGES; i++)
		kernel_page_table[i] = MAKE_PTE_ITEM(i << 12, PAGE_SYSTEM | PAGE_PRESENT);
	/*
	 * Page frame #0x9D ~ #0x9E are used as kernel stack.
	 * And #0x9F ~ #0xFF is are used as BIOS and video card.
	 */
	for (i = 0x9D; i < 0x100; i++)
		kernel_page_table[i] = MAKE_PTE_ITEM(i << 12, PAGE_SYSTEM | PAGE_PRESENT);

	/* Enter page mode */
	set_cr3((void*)kernel_page_dir_table);
	start_paging();
}

/* Allocate a PHYSICAL page and return PHYSICAL address. */
void* alloc_page(dword attr)
{
	static SPIN_LOCK lock;

	int i, j, page_num, end;

	if (attr == PAGE_USER)
	{
		i = 128;
		end = SIZE_OF_MEM_BMP;
	}
	else
	{
		/* Kernel is below 4MB for convenience. */
		i = 5;
		end = 128;
	}

	spin_lock(&lock);
	for (; i < end; i++)
	{
		/* Scanning by bytes instead of by bits */
		if (memory_bitmap[i] != 0xFF)
		{
			page_num = i << 3;
			for (j = 0; j < 8; j++, page_num++)
			{
				if (is_page_free(page_num))
				{
					set_page(page_num, PAGE_USED);
					spin_unlock(&lock);
					return (void*)(page_num << 12);
				}
			}
		}
	}

	/* TODO: Do swap out */
	panic("Run out of memory!");
	return NULL;
}



/*	Virtual page allocation. It allocates a VIRTUAL page at current
 * virtual memory. v_addr is address in virtual memory. p_addr is
 * address in physical memory. attr indicates attributes of this page.
 * 
 * NOTICE: If you don't know or not sure how it works,
 * don't make any changes on it!
 */
void* valloc_page(dword v_addr, dword p_addr, dword attr)
{
	/* This virtual address points to itself */
	PAGE_DIRECTORY_TABLE pdt = (PAGE_DIRECTORY_TABLE)0xFFFFF000;
	dword pdt_index = GET_PAGE_TABLE_INDEX(v_addr);
	dword pte_index = GET_PAGE_INDEX(v_addr);
	/* This virtual address points to page table */
	PAGE_TABLE pte = (PAGE_TABLE)(0xFFC00000 + (pte_index << 12));
	void* p;
	int i;

	/* Corresponding page table is not allocated */
	if (!pdt[pdt_index])
	{
		p = alloc_page(PAGE_SYSTEM);

		pdt[pdt_index] = MAKE_PDT_ITEM(p, PAGE_USER | PAGE_PRESENT | PAGE_READ_WRITE);
		invalidate_page((void*)v_addr);

		/* Virtual pages are not allocated initially */
		for (i = pte_index; i < pte_index + NUM_OF_PAGE; i++)
		{
			p = MAKE_VA(1023, pdt_index, i << 2);
			*(PAGE_ITEM*)p = 0;
		}
	}

	p = MAKE_VA(1023, pdt_index, pte_index << 2);
	/* Corresponding page is allocated */
	if (*(PAGE_ITEM*)p)
		return NULL;

	/* Map v_addr onto p_addr */
	*(PAGE_ITEM*)p = MAKE_PTE_ITEM(p_addr, attr);
	invalidate_page((void*)v_addr);

	return (void*)v_addr;
}


void free_page(void* ptr)
{
	set_page((dword)ptr >> 12, PAGE_FREE);
}

void vfree_page(void* vptr)
{
	/* TODO: Delete corresponding virtual page and physical page */
}


/* Handler of fault general protection */
void CALLBACK handle_gp(THREAD_CONTEXT* regs)
{
	UNUSED(regs);
	kprintf("General protection!\neip: 0x%X\nErr code: %d\n", regs->eip, regs->err_code);
}

/* Handler of page fault */
/*
err_code:
 31              4               0
+--------------+---+---+---+---+---+
|   Reserved   | I | R | U | W | P |
+--------------+---+---+---+---+---+
*/
void CALLBACK handle_pf(THREAD_CONTEXT* regs)
{
	UNUSED(regs);

	/* TODO: Do swap in */

	kprintf("Page fault!\n");
	kprintf("Error code: %bB\n", regs->err_code);
	kprintf("Address: 0x%p\n", get_page_fault_addr());
	kprintf("CR3: 0x%p\n", get_cr3());
	kprintf("eip: 0x%p\n", regs->eip);

	while (1);
}


/* Internel functions */

void set_page(dword page_num, dword attr)
{
	dword byte_num = page_num >> 3;				/* byte_num = page_num / 8; */
	dword bit_num = page_num & 7;				/* bit_num = page_num % 8; */

	if (attr == PAGE_FREE)
		memory_bitmap[byte_num] &= ~(1 << bit_num);	/* Clear the bit */
	else
		memory_bitmap[byte_num] |= (1 << bit_num);	/* Set the bit */
}

dword is_page_free(dword page_num)
{
	return !(memory_bitmap[page_num >> 3] & (1 << (page_num & 7)));
}
