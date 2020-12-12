#define CLOCK_C

#include "../kernel/types.h"
#include "../cpu/seg.h"
#include "../kernel/task.h"
#include "clock.h"
#include "../cpu/isr.h"
#include "../cpu/idt.h"
#include "ports.h"
#include "screen.h"
#include "../include/function.h"


/* Private variables */
static dword tick = 50;

static void clock_callback(THREAD_CONTEXT*);

void init_clock(dword freq)
{
	/* Get the PIT value: hardware clock at 1193180 Hz */
	dword divisor = 1193180 / freq;
	byte low = (byte)(divisor & 0xFF);
	byte high = (byte)((divisor >> 8) & 0xFF);

	/* Install the function we just wrote */
	set_interrupt_handler(IRQ0, clock_callback);

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

static void clock_callback(THREAD_CONTEXT* regs)
{
	tick++;
	if (tick % 50 == 0)
		kprintf("%d\n", tick);
	UNUSED(regs);
}
