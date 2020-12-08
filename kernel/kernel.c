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
#include "../cpu/seg.h"
#include "task.h"
#include "kernel.h"
#include "../drivers/screen.h"
#include "../cpu/page.h"
#include "../cpu/isr.h"
#include "../cpu/idt.h"
#include "../include/stdlib.h"
#include "../drivers/apm.h"
#include "../drivers/ports.h"
#include "sys_call.h"
#include "../drivers/hard_disk.h"


#define KERNEL_STACK_BASE	0x90000


/* Definition of OS information */
word os_ver = MAKEWORD(MINOR_OS_VER, MAJOR_OS_VER);
char os_name[] = OS_NAME;


void print_os_info()
{
	kprint("Kernel loaded.\n");
	kprintf("Version: %d.%d\n", HIBYTE(os_ver), LOBYTE(os_ver));
	kprintf("Welcome to %s\n", os_name);
}

void test()
{
	void print_screen(char*);

	print_screen("System call with one argument.\n");
//	__asm("int $3");

	while (1);
}


void kernel_main()
{
	init_gdt();				/* Reinitialize GDT and GDTR */
	init_apm();

//	init_page();			/* Initialize PDE and PTE */
//	start_paging();			/* Enable page mode */

	init_interrupts();		/* Initialize IDT and IDTR, and enable interrupts */
	init_sys_call();		/* Initialize system call */

//	clear_screen();
//	print_os_info();

//	pio_hd_read_sector((void*)0x30000, 20, 0, 1, 0, 0);

//	suspend();
//	stand_by();
//	reset();
//	shutdown();

	//void get_pci_cfg();
	//get_pci_cfg();

	init_task((dword)test);
	rdy_task = &task_table[0];
	start_task(rdy_task);

	/* Infinite loop, waiting for interrupts. */
	while (1);
}
