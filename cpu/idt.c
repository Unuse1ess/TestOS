/*--------------------------------------------------------------
 *								History
 *	Version 0.1:
 *		2020/11/15 Created by MYM.
 *
 *-------------------------------------------------------------*/

#define IDT_C

#include "../kernel/types.h"
#include "seg.h"
#include "page.h"
#include "../kernel/task.h"
#include "isr.h"
#include "idt.h"
#include "../drivers/ports.h"
#include "../drivers/keyboard.h"
#include "../drivers/timer.h"
#include "../drivers/hard_disk.h"
#include "../kernel/sys_call.h"


INTERRUPT_DESCRIPTOR idt[NUM_OF_INT_DESC];


extern void load_idtr(u16 size, INTERRUPT_DESCRIPTOR* idt);
extern void CALLBACK handle_de();
extern void CALLBACK handle_db();
extern void CALLBACK handle_bp();
extern void CALLBACK handle_of();
extern void CALLBACK handle_br();
extern void CALLBACK handle_ud();
extern void CALLBACK handle_nm();
extern void CALLBACK handle_gp();
extern void CALLBACK handle_pf();
extern void CALLBACK handle_mf();



/* Install interrupt entries 0 ~ 47 */
void init_idt()
{
	/* Install handler of CPU-reserved interrupts */
	set_idt_gate(0, (u32)isr0);
	set_idt_gate(1, (u32)isr1);
	set_idt_gate(2, (u32)isr2);
	set_idt_gate(3, (u32)isr3);
	set_idt_gate(4, (u32)isr4);
	set_idt_gate(5, (u32)isr5);
	set_idt_gate(6, (u32)isr6);
	set_idt_gate(7, (u32)isr7);
	set_idt_gate(8, (u32)isr8);
	set_idt_gate(9, (u32)isr9);
	set_idt_gate(10, (u32)isr10);
	set_idt_gate(11, (u32)isr11);
	set_idt_gate(12, (u32)isr12);
	set_idt_gate(13, (u32)isr13);
	set_idt_gate(14, (u32)isr14);
	set_idt_gate(15, (u32)isr15);
	set_idt_gate(16, (u32)isr16);
	set_idt_gate(17, (u32)isr17);
	set_idt_gate(18, (u32)isr18);
	set_idt_gate(19, (u32)isr19);
	set_idt_gate(20, (u32)isr20);
	set_idt_gate(21, (u32)isr21);
	set_idt_gate(22, (u32)isr22);
	set_idt_gate(23, (u32)isr23);
	set_idt_gate(24, (u32)isr24);
	set_idt_gate(25, (u32)isr25);
	set_idt_gate(26, (u32)isr26);
	set_idt_gate(27, (u32)isr27);
	set_idt_gate(28, (u32)isr28);
	set_idt_gate(29, (u32)isr29);
	set_idt_gate(30, (u32)isr30);
	set_idt_gate(31, (u32)isr31);

	/* Install the IRQs */
	set_idt_gate(IRQ0, (u32)irq0);
	set_idt_gate(IRQ1, (u32)irq1);
	set_idt_gate(IRQ2, (u32)irq2);
	set_idt_gate(IRQ3, (u32)irq3);
	set_idt_gate(IRQ4, (u32)irq4);
	set_idt_gate(IRQ5, (u32)irq5);
	set_idt_gate(IRQ6, (u32)irq6);
	set_idt_gate(IRQ7, (u32)irq7);
	set_idt_gate(IRQ8, (u32)irq8);
	set_idt_gate(IRQ9, (u32)irq9);
	set_idt_gate(IRQ10, (u32)irq10);
	set_idt_gate(IRQ11, (u32)irq11);
	set_idt_gate(IRQ12, (u32)irq12);
	set_idt_gate(IRQ13, (u32)irq13);
	set_idt_gate(IRQ14, (u32)irq14);
	set_idt_gate(IRQ15, (u32)irq15);

	/* Reserved for user */
	for (int i = 48; i < 256; i++)
		set_idt_gate(i, (u32)isr_not_used);
}

void init_irq()
{
	/* Initialization of 8059A */
	/* Write ICW1 */
	/* Needs ICW4 and edge triggered mode */
	port_byte_out(ICW1_MASTER, 0x11);
	port_byte_out(ICW1_SLAVE, 0x11);

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
	/* Disable all interrupts from 8259A, except slave 8259A. */
	port_byte_out(0x21, 0xFB);
	port_byte_out(0xA1, 0xFF);
}

void INLINE set_idt_gate(int n, u32 handler)
{
	idt[n] = MAKE_GATE_DESC(KERNEL_CS, handler, SEG_PRESENT | SYSTEM_DESCPRITOR | INTERRUPT_GATE_386);
}


void init_exceptions()
{
	set_interrupt_handler(INT_DE, handle_de);
	set_interrupt_handler(INT_DB, handle_db);

	/* int 3 ~ 5 are enabled at user mode */
	set_interrupt_handler(INT_BP, handle_bp);
	idt[INT_BP] |= DPL_RING3;
	set_interrupt_handler(INT_OF, handle_of);
	idt[INT_OF] |= DPL_RING3;
	set_interrupt_handler(INT_BR, handle_br);
	idt[INT_BR] |= DPL_RING3;

	set_interrupt_handler(INT_UD, handle_ud);
	set_interrupt_handler(INT_NM, handle_nm);
	set_interrupt_handler(INT_GP, handle_gp);

	set_interrupt_handler(INT_PF, handle_pf);

	set_interrupt_handler(INT_MF, handle_mf);
}

void init_interrupts()
{
	init_idt();
	init_exceptions();		/* Initialize CPU exceptions' handlers */

	/* Load idtr */
	load_idtr(sizeof(idt) - 1, idt);

	init_irq();
	init_clock(50);			/* IRQ0: clock, 50ms per tick */
	init_keyboard();		/* IRQ1: keyboard */
	init_hd();				/* Init hard disk */
}
