/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/13 Created by MYM. Created the kernel of OS.
 * 
 *-------------------------------------------------------------*/

#define KERNEL_C

#include "types.h"
#include "../cpu/seg.h"
#include "../cpu/page.h"
#include "task.h"
#include "memory.h"
#include "kernel.h"
#include "../drivers/screen.h"
#include "../cpu/isr.h"
#include "../cpu/idt.h"
#include "../include/stdlib.h"
#include "../drivers/apm.h"
#include "../drivers/ports.h"
#include "sys_call.h"
#include "../drivers/hard_disk.h"
#include "../drivers/rtc.h"
#include "../drivers/pci.h"


/* Definition of OS information */
word os_ver = MAKEWORD(MINOR_OS_VER, MAJOR_OS_VER);
char os_name[] = OS_NAME;


void print_os_info()
{
	kprint("Kernel loaded.\n");
	kprintf("Version: %d.%d\n", HIBYTE(os_ver), LOBYTE(os_ver));
	kprintf("Welcome to %s\n", os_name);
}

void print_screen(char* str);
void test()
{
	int i = 16, j = 0;

	i /= j;

	while (1);
}


void kernel_main()
{
	init_gdt();				/* Reinitialize GDT and GDTR */
	init_tss();
	init_ldt();

	init_apm();

	init_interrupts();		/* Initialize IDT and IDTR, and enable interrupts */
	init_sys_call();		/* Initialize system call */

	init_memory();			/* Initialize memory information and enter page mode */

	clear_screen();
	print_os_info();

//	checkAllBuses();
	extern void test_A();
	extern void test_B();

//	create_proc(test);
	create_proc((void*)test_A);
	create_proc((void*)test_B);
	schedule();
}
