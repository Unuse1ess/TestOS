/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/15 Created by MYM.
 *
 *-------------------------------------------------------------*/

#include "../kernel/types.h"
#include "../cpu/seg.h"
#include "../cpu/page.h"
#include "../kernel/task.h"
#include "timer.h"
#include "../cpu/isr.h"
#include "../cpu/idt.h"
#include "ports.h"
#include "screen.h"
#include "../include/function.h"


dword volatile tick = 0;

static void do_timer();

void init_clock(dword freq)
{
	/* Get the PIT value: hardware clock at 1193180 Hz */
	dword divisor = 1193180 / freq;
	byte low = (byte)(divisor & 0xFF);
	byte high = (byte)((divisor >> 8) & 0xFF);

	/* Install the function */
	set_interrupt_handler(IRQ0, do_timer);

	/* Send the command */
	port_byte_out(0x43, 0x36); /* Command port */
	port_byte_out(0x40, low);
	port_byte_out(0x40, high);

	/* Enable clock interrupt (IRQ0, at master chip) */
	port_byte_out(0x21, port_byte_in(0x21) & ~1);
}

dword sys_get_tick()
{
	return tick;
}


/* Internel function */

static void do_timer()
{
	tick++;
	/* TODO: Clear the accessed bit of pages and add references. */
	schedule();
}
