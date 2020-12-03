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

#include "types.h"

#ifndef INT_SYSCALL
#define INT_SYSCALL 0x80
#endif

typedef int (*SYS_SRV_ROUTINE)(dword);

void init_sys_call();

extern void sys_call(THREAD_CONTEXT* regs);
extern int sys_print_screen(dword);


#endif