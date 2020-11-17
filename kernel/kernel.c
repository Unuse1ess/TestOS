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
#include "../cpu/isr.h"
#include "../cpu/seg.h"

/* Definition of OS information */
word os_ver = MAKEWORD(MINOR_OS_VER, MAJOR_OS_VER);
char os_name[] = OS_NAME;


void print_os_info()
{
	kprint("Kernel loaded.\n");
	kprintf("Version: %d.%d\n", HIBYTE(os_ver), LOBYTE(os_ver));
	kprintf("Welcome to %s\n", os_name);
}

extern dword tick;

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
	kprintf("tick: %d", tick);
}


void kernel_main()
{
	reload_gdt(gdt);

	isr_install();
	irq_install();

	clear_screen();
	print_os_info();

	kprintf("%p\n", gdt);
	kprintf("%d", gdt[1].AVL);

	/* Infinite loop, waiting for interrupts. */
	while (1);
}
