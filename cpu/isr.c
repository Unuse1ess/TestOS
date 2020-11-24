/*--------------------------------------------------------------
 *						Time: 2020/11/14
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/14 created by MYM.
 *
 *-------------------------------------------------------------*/

#define ISR_C

#include "isr.h"
#include "../drivers/screen.h"
#include "../drivers/ports.h"

/*	When CPU received interrupt:
 *	1. Find ISR according to the IDT according to interrupt number.
 *	2. Turn to execute the ISR which is written in interrupt.asm.
 *  3. The assembly codes call isr_handler().
 *	4. If interrupt_handerls[] has corresponding function, it will call it.
 *	5. Return.
 */

ISR_HANDLER interrupt_handlers[256];


/* To print the message which defines every exception */
char* exception_messages[] =
{
	"Division By Zero",
	"Debug",
	"Non Maskable Interrupt",
	"Breakpoint",
	"Into Detected Overflow",
	"Out of Bounds",
	"Invalid Opcode",
	"No Coprocessor",

	"Double Fault",
	"Coprocessor Segment Overrun",
	"Bad TSS",
	"Segment Not Present",
	"Stack Fault",
	"General Protection Fault",
	"Page Fault",
	"Unknown Interrupt",

	"Coprocessor Fault",
	"Alignment Check",
	"Machine Check",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",

	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved",
	"Reserved"
};

void isr_handler(THREAD_CONTEXT r)
{
	if (interrupt_handlers[r.int_no] != 0)
	{
		(*interrupt_handlers[r.int_no])(r);
	}
	else
	{
		kprintf("received interrupt: 0x%X\n", r.int_no);
		kprintf("Message: %s\n", exception_messages[r.int_no]);
		while (1);
	}
}

void irq_handler(THREAD_CONTEXT r)
{
	if (interrupt_handlers[r.int_no] != 0)
		(*interrupt_handlers[r.int_no])(r);

	/* After every interrupt we need to send an EOI to the PICs
	 * or they will not send another interrupt again.
	 */
	if (r.int_no >= 40)
		port_byte_out(0xA0, 0x20);	/* slave */
	port_byte_out(0x20, 0x20);		/* master */
}
