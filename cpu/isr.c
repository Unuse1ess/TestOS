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

/*	When CPU received interrupt:
 *	1. Find ISR according to the IDT according to interrupt number.
 *	2. Turn to execute the ISR which is written in interrupt.asm.
 *  3. The assembly codes call isr_handler().
 *	4. If interrupt_handerls[] has corresponding function, it will call it.
 *	5. Return.
 */

extern THREAD* rdy_thread;

static ISR_HANDLER interrupt_handlers[256];

void set_interrupt_handler(byte n, ISR_HANDLER handler)
{
	interrupt_handlers[n] = handler;
}


/* Internel data and functions */

void isr_handler()
{
	THREAD_CONTEXT* r = &rdy_thread->regs;
	
	if (interrupt_handlers[r->int_no] != 0)
	{
		(*interrupt_handlers[r->int_no])(r);
	}
	else if(r->int_no > 47)
	{
		kprintf("received interrupt: 0x%X\n", r->int_no);
		kprintf("eip: 0x%X\n", r->eip);
		while (1);
	}

	/* After every interrupt we need to send an EOI to the PICs
	 * or they will not send another interrupt again.
	 */
	if (r->int_no >= 32 || r->int_no <= 47)
	{
		if (r->int_no >= 40)
			port_byte_out(0xA0, 0x20);	/* slave */
		port_byte_out(0x20, 0x20);		/* master */
	}
}
