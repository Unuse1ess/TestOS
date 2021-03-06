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
#include "../cpu/math.h"
#include "spin_lock.h"

#include "../cpu/apic.h"
#include "../cpu/msr.h"


__attribute__((section(".boot")))
static byte boot_sect[512];

struct _dummy {};

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
	init_gdt();
	init_tss(); 
	init_ldt();

//	init_apm();

	init_interrupts();
	init_sys_call();

	init_memory();

	init_fpu();

	clear_screen();

//	print_os_info();

	//u64 i, j;
	//void init_apic();

	//init_apic();
	//read_msr(IA32_APIC_BASE, &i);
	//i &= 0xFF800FFF;
	//write_msr(IA32_APIC_BASE, i);
	//read_msr(IA32_APIC_BASE, &j);

	//kprintf("%x\n", (u32)j);
	//kprintf("%x\n", (*(volatile u32*)LAPIC_SVR));


	extern void test_A();
	extern void test_B();
	extern void test_C();

	create_proc((void*)test_A, PRIORITY_NORMAL);
	create_proc((void*)test_B, PRIORITY_NORMAL);
	create_proc((void*)test_C, PRIORITY_NORMAL);
	schedule();
}
