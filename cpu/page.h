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


/* Macros for page attribute */
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


#define GET_PAGE_TABLE_INDEX(addr)	((((dword)(addr) >> 22) & 0x3FF))
#define GET_PAGE_TABLE_OFFSET(addr)	((((dword)(addr) >> 20) & 0x3FF))
#define GET_PAGE_INDEX(addr)		((((dword)(addr) >> 12) & 0x3FF))
#define GET_PAGE_OFFSET(addr)		((((dword)(addr) >> 10) & 0x3FF))
#define GET_OFFSET_IN_PAGE(addr)	((dword)addr & 0xFFF)


#define MEM_ALIGN(size, align) (((dword)(size) + ((align) - 1)) & ~((align) - 1))


#define GET_PAGE_BASE(l, h) ((dword)(((dword)(l)) | (((dword)(h)) << 4)))


 /* Cancel the alignment */
#pragma pack(push, 1)

typedef struct
{
	byte attribute;
	byte global_page : 1;
	byte avl : 3;				/* AVL bits for OS, plan to make it the number of not being accessed. */
	byte base_low : 4;			/* Low 4 bits of address */
	word base_high;				/* High 16 bits of address */
}PAGE_ITEM, *PAGE_DIRECTORY_TABLE, *PAGE_TABLE;

/* Strucutre of memory information */
typedef struct
{
	qword base_addr;
	qword length;
	dword type;
}MEMORY_BLOCK_INFO;



/* Pop previous alignment out */
#pragma pack(pop)
//
//#define MAKE_PAGE_ITEM(addr, attr) (addr >> 12)
//
//typedef dword PAGE_ITEM, *PAGE_DIRECTORY_TABLE, *PAGE_TABLE;

/* Implemented in page.asm */
extern void start_paging();
extern dword get_page_fault_addr();
extern void set_cr3(void* pdt_base);

/* Implemented in memory.c */
void init_memory();
void set_page(dword page_num, dword attr);

/* Call back function of ISR */
void CALLBACK gp_handler(THREAD_CONTEXT* regs);
void CALLBACK pf_handler(THREAD_CONTEXT* regs);

#endif