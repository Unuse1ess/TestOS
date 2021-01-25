/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2021/1/23 created by MYM.
 *
 *-------------------------------------------------------------*/

#ifndef MEMORY_H
#define MEMORY_H

#ifndef TYPES_H
#error "kernel/types.h" is not included
#endif // !TYPES_H


void init_memory();
void set_page(dword page_num, dword attr);
void* alloc_page(dword attr);
void* valloc_page(dword v_addr, dword p_addr, dword attr);
void vfree_page(void* vptr);
void free_page(void* ptr);


#endif // !MEMORY_H

