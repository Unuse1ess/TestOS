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

#define SIZE_OF_PAGE				0x1000		/* Size of a page is 4KB */


/* Macros for page attribute */
#define PAGE_NOTPRESENT				0x00
#define PAGE_PRESENT				0x01

#define PAGE_READ_ONLY				0x00
#define PAGE_READ_WRITE				0x02

#define PAGE_SYSTEM					0x00
#define PAGE_USER					0x04

#define PAGE_WRITE_BACK				0x00
#define PAGE_WRITE_THROUGH			0x08

#define PAGE_CACHEABLE				0x00
#define PAGE_NOTCACHEABLE			0x10

#define PAGE_NOTACCESSED			0x00
#define PAGE_ACCESSED				0x20

#define PAGE_NOTDIRTY				0x00
#define PAGE_DIRTY					0x40

#define PAGE_GLOBAL					0x100


#define GET_PAGE_TABLE_INDEX(addr)	((((dword)(addr) >> 22) & 0x3FF))
#define GET_PAGE_TABLE_OFFSET(addr)	((((dword)(addr) >> 20) & 0x3FF))
#define GET_PAGE_INDEX(addr)		((((dword)(addr) >> 12) & 0x3FF))
#define GET_PAGE_OFFSET(addr)		((((dword)(addr) >> 10) & 0x3FF))
#define GET_OFFSET_IN_PAGE(addr)	((dword)addr & 0xFFF)

#define MAKE_VA(ipdt, ipte, offset)	(void*)((((dword)(ipdt) & 0x3FF) << 22) | \
										(((dword)(ipte) & 0x3FF) << 12) | \
										(((dword)(offset) & 0xFFF)))


#define MEM_ALIGN(size, align) (((dword)(size) + ((align) - 1)) & ~((align) - 1))

#define MAKE_PDT_ITEM(addr, attr) (((dword)(addr) & 0xFFFFF000) | ((attr) & 0xFFF))
#define MAKE_PTE_ITEM MAKE_PDT_ITEM

 /* Cancel the alignment */
#pragma pack(push, 1)

//typedef struct
//{
//	byte attribute;
//	byte global_page : 1;
//	byte avl : 3;				/* AVL bits for OS, plan to make it the number of not being accessed. */
//	byte base_low : 4;			/* Low 4 bits of address */
//	word base_high;				/* High 16 bits of address */
//}PAGE_ITEM, *PAGE_DIRECTORY_TABLE, *PAGE_TABLE;

typedef dword PAGE_ITEM, *PAGE_DIRECTORY_TABLE, *PAGE_TABLE;

/* Strucutre of memory information */
typedef struct
{
	qword base_addr;
	qword length;
	dword type;
}MEMORY_BLOCK_INFO;

/* Pop previous alignment out */
#pragma pack(pop)


/* Implemented in page.asm */
extern void start_paging();
extern dword get_page_fault_addr();
extern void set_cr3(void* pdt_base);
extern PAGE_DIRECTORY_TABLE get_cr3();
extern void invalidate_page(void* v_addr);


#endif