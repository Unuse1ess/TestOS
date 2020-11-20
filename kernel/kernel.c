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
#include "../cpu/seg.h"
#include "../cpu/page.h"
#include "../cpu/idt.h"
#include "../include/stdlib.h"

/* Definition of OS information */
word os_ver = MAKEWORD(MINOR_OS_VER, MAJOR_OS_VER);
char os_name[] = OS_NAME;


void print_os_info()
{
	kprint("Kernel loaded.\n");
	kprintf("Version: %d.%d\n", HIBYTE(os_ver), LOBYTE(os_ver));
	kprintf("Welcome to %s\n", os_name);
}

void user_input(char* input)
{
	//if (strcmp(input, "END") == 0)
	//{
	//	kprint("Stopping the CPU. Bye!\n");
	//	//	shutdown();
	//	asm volatile("hlt");
	//}
	//kprint("You said: ");
	//kprint(input);
	//kprint("\n> ");
}

void kernel_main()
{
	init_gdt();
	init_page();
	/* Enable page mode */
	start_paging();

	init_interrupts();

	clear_screen();
	print_os_info();

	char* a = (char*)0x10000000;
	a[0] = 1;

	/* Infinite loop, waiting for interrupts. */
	while (1);
}
