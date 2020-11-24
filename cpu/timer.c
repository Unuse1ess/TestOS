#include "timer.h"
#include "idt.h"
#include "../drivers/ports.h"
#include "../drivers/screen.h"
#include "../cpu/isr.h"
#include "../include/function.h"

dword tick = 0;

static void timer_callback(THREAD_CONTEXT regs)
{
	tick++;
	UNUSED(regs);
}

void init_timer(dword freq)
{
	/* Get the PIT value: hardware clock at 1193180 Hz */
	dword divisor = 1193180 / freq;
	byte low = (byte)(divisor & 0xFF);
	byte high = (byte)((divisor >> 8) & 0xFF);

	/* Install the function we just wrote */
	set_interrupt_handler(INT_IRQ0, timer_callback);

	/* Send the command */
	port_byte_out(0x43, 0x36); /* Command port */
	port_byte_out(0x40, low);
	port_byte_out(0x40, high);
}

