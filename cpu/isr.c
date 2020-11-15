#include "isr.h"
#include "seg.h"
#include "../drivers/screen.h"
#include "../drivers/keyboard.h"
#include "../include/string.h"
#include "timer.h"
#include "../drivers/ports.h"

isr_t interrupt_handlers[256];

/* Can't do this with a loop because we need the address
 * of the function names */
void isr_install()
{
	set_idt_gate(0, (dword)isr0);
	set_idt_gate(1, (dword)isr1);
	set_idt_gate(2, (dword)isr2);
	set_idt_gate(3, (dword)isr3);
	set_idt_gate(4, (dword)isr4);
	set_idt_gate(5, (dword)isr5);
	set_idt_gate(6, (dword)isr6);
	set_idt_gate(7, (dword)isr7);
	set_idt_gate(8, (dword)isr8);
	set_idt_gate(9, (dword)isr9);
	set_idt_gate(10, (dword)isr10);
	set_idt_gate(11, (dword)isr11);
	set_idt_gate(12, (dword)isr12);
	set_idt_gate(13, (dword)isr13);
	set_idt_gate(14, (dword)isr14);
	set_idt_gate(15, (dword)isr15);
	set_idt_gate(16, (dword)isr16);
	set_idt_gate(17, (dword)isr17);
	set_idt_gate(18, (dword)isr18);
	set_idt_gate(19, (dword)isr19);
	set_idt_gate(20, (dword)isr20);
	set_idt_gate(21, (dword)isr21);
	set_idt_gate(22, (dword)isr22);
	set_idt_gate(23, (dword)isr23);
	set_idt_gate(24, (dword)isr24);
	set_idt_gate(25, (dword)isr25);
	set_idt_gate(26, (dword)isr26);
	set_idt_gate(27, (dword)isr27);
	set_idt_gate(28, (dword)isr28);
	set_idt_gate(29, (dword)isr29);
	set_idt_gate(30, (dword)isr30);
	set_idt_gate(31, (dword)isr31);

	// Remap the PIC
	port_byte_out(0x20, 0x11);
	port_byte_out(0xA0, 0x11);
	port_byte_out(0x21, 0x20);
	port_byte_out(0xA1, 0x28);
	port_byte_out(0x21, 0x04);
	port_byte_out(0xA1, 0x02);
	port_byte_out(0x21, 0x01);
	port_byte_out(0xA1, 0x01);
	port_byte_out(0x21, 0x0);
	port_byte_out(0xA1, 0x0);

	// Install the IRQs
	set_idt_gate(32, (dword)irq0);
	set_idt_gate(33, (dword)irq1);
	set_idt_gate(34, (dword)irq2);
	set_idt_gate(35, (dword)irq3);
	set_idt_gate(36, (dword)irq4);
	set_idt_gate(37, (dword)irq5);
	set_idt_gate(38, (dword)irq6);
	set_idt_gate(39, (dword)irq7);
	set_idt_gate(40, (dword)irq8);
	set_idt_gate(41, (dword)irq9);
	set_idt_gate(42, (dword)irq10);
	set_idt_gate(43, (dword)irq11);
	set_idt_gate(44, (dword)irq12);
	set_idt_gate(45, (dword)irq13);
	set_idt_gate(46, (dword)irq14);
	set_idt_gate(47, (dword)irq15);

	set_idt(); // Load with ASM
}

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

void isr_handler(registers_t r)
{
	kprintf("received interrupt: %X\n", r.int_no);
	kprintf("Message: %s\n", exception_messages[r.int_no]);
}

void register_interrupt_handler(byte n, isr_t handler)
{
	interrupt_handlers[n] = handler;
}

void irq_handler(registers_t r)
{
	/* After every interrupt we need to send an EOI to the PICs
	 * or they will not send another interrupt again */
	if (r.int_no >= 40) port_byte_out(0xA0, 0x20); /* slave */
	port_byte_out(0x20, 0x20); /* master */

	/* Handle the interrupt in a more modular way */
	if (interrupt_handlers[r.int_no] != 0)
	{
		isr_t handler = interrupt_handlers[r.int_no];
		handler(r);
	}
}

void irq_install()
{
	/* Enable interruptions */
	__asm__ volatile("sti");
	/* IRQ0: timer */
	init_timer(50);
	/* IRQ1: keyboard */
	init_keyboard();
}
