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
	/* Install handler of CPU-reserved interrupts */
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

	/* Initialization of 8059A */
	/* Write ICW1 */
	/* Needs ICW4 and edge triggered mode */
	port_byte_out(ICW1_MASTER, 0x11);
	port_byte_out(ICW1_MASTER, 0x11);

	/* Write ICW2 */
	/* In this step, IRQ0~IRQ7 is mapped to interrupt 0x20~0x27. */
	port_byte_out(ICW2_MASTER, 0x20);
	/* In this step, IRQ8~IRQ15 is mapped to interrupt 0x28~0x2F. */
	port_byte_out(ICW2_SLAVE, 0x28);

	/* Write ICW3 */
	/* Slave 8259A is linked to master's IRQ2 */
	port_byte_out(ICW3_MASTER, 0x04);
	port_byte_out(ICW3_SLAVE, 0x02);

	/* Write ICW4 */
	/* 80x86 mode and normal EOI */
	port_byte_out(ICW4_MASTER, 0x01);
	port_byte_out(ICW4_SLAVE, 0x01);

	/* Write OCW1 */
	/* Enable all interrupts from 8259A */
	port_byte_out(0x21, 0x0);
	port_byte_out(0xA1, 0x0);

	/* Install the IRQs */
	set_idt_gate(INT_IRQ0, (dword)irq0);
	set_idt_gate(INT_IRQ1, (dword)irq1);
	set_idt_gate(INT_IRQ2, (dword)irq2);
	set_idt_gate(INT_IRQ3, (dword)irq3);
	set_idt_gate(INT_IRQ4, (dword)irq4);
	set_idt_gate(INT_IRQ5, (dword)irq5);
	set_idt_gate(INT_IRQ6, (dword)irq6);
	set_idt_gate(INT_IRQ7, (dword)irq7);
	set_idt_gate(INT_IRQ8, (dword)irq8);
	set_idt_gate(INT_IRQ9, (dword)irq9);
	set_idt_gate(INT_IRQ10, (dword)irq10);
	set_idt_gate(INT_IRQ11, (dword)irq11);
	set_idt_gate(INT_IRQ12, (dword)irq12);
	set_idt_gate(INT_IRQ13, (dword)irq13);
	set_idt_gate(INT_IRQ14, (dword)irq14);
	set_idt_gate(INT_IRQ15, (dword)irq15);

	/* Load with ASM */
	set_idt();
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
	if (r.int_no >= 40)
		port_byte_out(0xA0, 0x20); /* slave */
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
