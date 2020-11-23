/*--------------------------------------------------------------
 *						Time: 2020/11/15
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/13 created by MYM.
 *
 *-------------------------------------------------------------*/

#include "types.h"

#ifndef KERNEL_H
#define KERNEL_H

 /* OS version: 0.1 */
#define MAJOR_OS_VER		0
#define MINOR_OS_VER		1

/* Name of OS */
#define OS_NAME				"MYM-OS"

#define KERNEL_STACK_BASE	0x90000

#ifndef KERNEL_C
extern word os_ver;
extern char os_name[];
#endif

/* Kernel function */
void print_os_info();
int kprintf(char* fmt, ...);
void user_input(char*);

#endif