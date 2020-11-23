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
#include "proc.h"
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

void test()
{
//	__asm("cli");
	kprintf("PROCESS\n");
	while (1);
}


void kernel_main()
{
	init_gdt();				/* Reinitialize GDT and GDTR */
	init_tss();

//	init_page();			/* Initialize PDE and PTE */
//	start_paging();			/* Enable page mode */

	init_interrupts();		/* Initialize IDT and IDTR, and enable interrupts */

	clear_screen();
	print_os_info();

//	init_process((dword)test);
//	restart(proc_table);

	/* Infinite loop, waiting for interrupts. */
	while (1);
}
