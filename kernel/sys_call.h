/*--------------------------------------------------------------
 *						Time: 2020/11/24
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/24 created by MYM.
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
extern void sys_print_screen(char*);

#endif