/*--------------------------------------------------------------
 *						Time: 2020/11/19
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/19 created by MYM. This header file defines
 * basic things of memory page of protection mode.
 *
 *-------------------------------------------------------------*/

#ifndef PAGE_H
#define PAGE_H

#include "../kernel/types.h"

/* The OS use 0x00000~0x10000, using 16 pages. */

#define MAX_NUM_OF_PAGE_TABLE		0x400		/* Maximum 1024 page tables */
#define MAX_SIZE_OF_PAGE_DIR_TABLE	0x1000		/* Page directory table's size is 4KB */

#define NUM_OF_PAGE_TABLE			0x20		/* 32 page tables so far */

#define NUM_OF_PAGE					0x400		/* 1024 pages in a page table */
#define SIZE_OF_PAGE_TABLE			0x1000		/* Page table's size is 4KB */

#define SIZE_OF_PAGE				0x1000		/* Size of a page is 4KB */


/* Macros for page item */
#define PAGE_NOTPRESENT				0x00
#define PAGE_PRESENT				0x01

#define PAGE_READ_ONLY				0x00
#define PAGE_READ_WRITE				0x02

#define PAGE_SYSTEM					0x00
#define PAGE_APPLICATION			0x04

#define PAGE_WRITE_BACK				0x00
#define PAGE_WRITE_THROUGH			0x08

#define PAGE_CACHEABLE				0x00
#define PAGE_NOTCACHEABLE			0x10

#define PAGE_NOTACCESSED			0x00
#define PAGE_ACCESSED				0x20

#define PAGE_NOTDIRTY				0x00
#define PAGE_DIRTY					0x40

#define PAGE_ALLOCATED				0x1
#define PAGE_NOTALLOCATED			0x0


#define GET_PAGE_TABLE_INDEX(addr)	((((addr) >> 22) & 0x3FF))
#define GET_PAGE_INDEX(addr)		((((addr) >> 12) & 0x3FF))
#define GET_OFFSET_IN_PAGE(addr)	(addr & 0xFFF)

#define GET_PAGE_BASE(l, h) ((dword)(((dword)(l)) | (((dword)(h)) << 4)))


/* Macros for page allocating. 
 * The lower byte is the same as above.
 */



 /* Cancel the alignment */
#pragma pack(push, 1)

typedef struct
{
	byte attribute;
	byte global_page : 1;
	byte allocated : 3;			/* AVL bits for OS, here we use it to indicated if it is allocated */
	byte base_low : 4;
	word base_high;
}PAGE_ITEM, *PAGE_DIRECTORY_TABLE, *PAGE_TABLE;

/* Pop previous alignment out */
#pragma pack(pop)

#ifndef MEMORY_C
extern PAGE_ITEM page_dir_table[MAX_NUM_OF_PAGE_TABLE];
extern PAGE_ITEM page_table[MAX_NUM_OF_PAGE_TABLE][NUM_OF_PAGE];
#endif

/* Implemented in start_page.asm */
extern void start_paging();

/* Implemented in memory.c */
void init_page();
dword get_phys_addr(dword virt_addr);

/* Call back function of ISR */
void CALLBACK gp_handler();
void CALLBACK page_fault_handler();

#endif