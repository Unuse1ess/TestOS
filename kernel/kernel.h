/*--------------------------------------------------------------
 *						Time: 2020/11/15
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/13 created by MYM.
 *
 *-------------------------------------------------------------*/

#ifndef KERNEL_H
#define KERNEL_H

#ifndef TYPES_H
#error "kernel/types.h" is not included
#endif

 /* OS version: 0.1 */
#define MAJOR_OS_VER		0
#define MINOR_OS_VER		1

/* Name of OS */
#define OS_NAME				"TestOS"


#ifndef KERNEL_C
extern word os_ver;
extern char os_name[sizeof(OS_NAME) / sizeof(char)];
#endif

/* Kernel function */
void print_os_info();

#endif