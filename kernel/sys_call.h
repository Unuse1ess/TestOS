/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/24 Created by MYM.
 *
 *-------------------------------------------------------------*/

/* This is used for kernel. */

#ifndef SYSCALL_H
#define SYSCALL_H

#ifndef TYPES_H
#error "kernel/types.h" is not included
#endif // !TYPES_H


void init_sys_call();

/* Implemented is print_screen.asm */
extern void sys_vprintf(char*);

#endif