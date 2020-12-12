/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/19 Created by MYM.
 *-------------------------------------------------------------*/

#ifndef PAGE_H
#define PAGE_H

#ifndef TYPES_H
#error "kernel/types.h" is not included
#endif

#ifndef TASK_H
#error "kernel/task.h" is not included
#endif


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

/* AVL bits, are used by OS to indicate page state of allcoated,
 * and page table table of full.
 */
#define PAGE_ALLOCATED				0x1
#define PAGE_NOTALLOCATED			0x0

#define PAGE_TABLE_FULL				0x2
#define PAGE_TABLE_NOT_FULL			0x0

#define GET_PAGE_TABLE_INDEX(addr)	((((dword)(addr) >> 22) & 0x3FF))
#define GET_PAGE_INDEX(addr)		((((dword)(addr) >> 12) & 0x3FF))
#define GET_OFFSET_IN_PAGE(addr)	((dword)addr & 0xFFF)

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
	byte allocated : 1;			/* AVL bits for OS, here we use it to indicated if it is allocated */
	byte avl : 2;				/* AVL bits for OS */
	byte base_low : 4;
	word base_high;
}PAGE_ITEM, *PAGE_DIRECTORY_TABLE, *PAGE_TABLE;

/* Pop previous alignment out */
#pragma pack(pop)

/* Implemented in page.asm */
extern void start_paging();
extern dword get_page_fault_addr();

/* Implemented in memory.c */
void init_page();
dword get_phys_addr(dword virt_addr);

/* Call back function of ISR */
void CALLBACK gp_handler(THREAD_CONTEXT* regs);
void CALLBACK pf_handler(THREAD_CONTEXT* regs);

#endif