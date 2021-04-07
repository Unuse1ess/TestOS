/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/15 Created by MYM.
 *
 *-------------------------------------------------------------*/

#include "../kernel/types.h"
#include "../cpu/seg.h"
#include "page.h"
#include "../kernel/task.h"
#include "isr.h"
#include "../drivers/screen.h"
#include "../drivers/ports.h"
#include "../include/stdlib.h"


#define enable_interrupt() __asm("sti")
#define disable_interrupt() __asm("cli")

/*	When CPU received interrupt:
 *	1. Find ISR according to the IDT according to interrupt number.
 *	2. Turn to execute the ISR which is written in interrupt.asm.
 *  3. The assembly codes call isr_handler().
 *	4. If interrupt_handerls[] has corresponding function, it will call it.
 *	5. Return.
 */

static ISR_HANDLER interrupt_handlers[256];

void set_interrupt_handler(byte n, ISR_HANDLER handler)
{ interrupt_handlers[n] = handler; }


/* Internel data and functions */

void isr_handler()
{
	THREAD_CONTEXT* r = &get_current_thread()->regs;

	get_current_thread()->nest_num++;

	//switch (r->int_no)
	//{
	////case INT_DE:
	////case INT_BP:
	////case INT_OF:
	////case INT_BR:
	//case INT_SYSCALL:
	//	enable_interrupt();

	//default:
	//	break;
	//}

	if (LIKELY(interrupt_handlers[r->int_no] != 0))
	{
		//kprintf("Received interrupt: 0x%X, nest_num: %d\n", r->int_no, get_current_thread()->nest_num);
		(*interrupt_handlers[r->int_no])();
	}
	else if(r->int_no > 47)
	{
		kprintf("Received interrupt: 0x%X\n", r->int_no);
		kprintf("eip: 0x%X\n", r->eip);
		while (1);
	}
	else
	{
		kprintf("Unknown interrupt: %d\n", r->int_no);
	}

	get_current_thread()->nest_num--;
}
