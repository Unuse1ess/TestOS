/*--------------------------------------------------------------
 *						Time: 2020/11/13
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/13 created by MYM. Create the kernel of OS.
 * 
 *-------------------------------------------------------------*/

#define KERNEL_C

#include "types.h"
#include "kernel.h"
#include "../drivers/screen.h"

/* Definition of OS information */
word os_ver = MAKEWORD(MINOR_OS_VER, MAJOR_OS_VER);
char os_name[] = OS_NAME;


void print_os_info()
{
	kprint("Kernel loaded.\n");
	kprintf("Version: %d.%d\n", HIBYTE(os_ver), LOBYTE(os_ver));
	kprintf("Welcome to %s\n", os_name);
}

void kernel_main()
{
	clear_screen();
	print_os_info();

	/* Infinite loop */
	while (1);
}
