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
#include "../drivers/apm.h"
#include "../drivers/ports.h"


/* Definition of OS information */
word os_ver = MAKEWORD(MINOR_OS_VER, MAJOR_OS_VER);
char os_name[] = OS_NAME;

extern void irq_common_stub();

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

extern dword tick;

void test()
{
	kprintf("PROCESS\n");
	kprintf("%d", (dword)&apm_data.call_gate - (dword)&apm_data);

	while (1);
}


void kernel_main()
{
	init_gdt();				/* Reinitialize GDT and GDTR */
	init_tss();

	init_apm();

//	init_page();			/* Initialize PDE and PTE */
//	start_paging();			/* Enable page mode */

	init_interrupts();		/* Initialize IDT and IDTR, and enable interrupts */

	clear_screen();
	print_os_info();

	suspend();
//	stand_by();
//	reset();
//	shutdown();

	proc_offset = 0;

	init_process((dword)test);
	restart(proc_table);

	/* Infinite loop, waiting for interrupts. */
	while (1);
}
