/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/13 Created by MYM. Created the kernel of OS.
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
#include "../drivers/rtc.h"



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
	void print_screen(char* str);
	int get_tick();

	print_screen("System call\n");
	int i = get_tick();

	while (1);
}

extern VBE_MODE_INFO vbe_mode_info;

void kernel_main()
{
	init_gdt();				/* Reinitialize GDT and GDTR */
	init_apm();

//	init_page();			/* Initialize PDE and PTE */
//	start_paging();			/* Enable page mode */

	init_interrupts();		/* Initialize IDT and IDTR, and enable interrupts */
	init_sys_call();		/* Initialize system call */

	clear_screen();
	print_os_info();
//	kprintf("Video memory: 0x%X\n", vbe_mode_info.phys_base);

//	pio_hd_read_sector((void*)0x30000, 16, 0, 2, 0, 0);

//	pio_hd_write_sector((void*)0x1000, 16, 0, 100, 0, 0);

	//void get_pci_cfg();
	//get_pci_cfg();

	init_task((dword)test);
	start_task(&task_table[0]);
}
