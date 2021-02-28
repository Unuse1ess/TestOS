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

/* Not exposed */
IDTR idtr;

extern void load_idtr();
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
	set_idt_gate(0, (dword)isr0, INTERRUPT_GATE_386);
	set_idt_gate(1, (dword)isr1, INTERRUPT_GATE_386);
	set_idt_gate(2, (dword)isr2, INTERRUPT_GATE_386);
	set_idt_gate(3, (dword)isr3, INTERRUPT_GATE_386);
	set_idt_gate(4, (dword)isr4, INTERRUPT_GATE_386);
	set_idt_gate(5, (dword)isr5, INTERRUPT_GATE_386);
	set_idt_gate(6, (dword)isr6, INTERRUPT_GATE_386);
	set_idt_gate(7, (dword)isr7, INTERRUPT_GATE_386);
	set_idt_gate(8, (dword)isr8, INTERRUPT_GATE_386);
	set_idt_gate(9, (dword)isr9, INTERRUPT_GATE_386);
	set_idt_gate(10, (dword)isr10, INTERRUPT_GATE_386);
	set_idt_gate(11, (dword)isr11, INTERRUPT_GATE_386);
	set_idt_gate(12, (dword)isr12, INTERRUPT_GATE_386);
	set_idt_gate(13, (dword)isr13, INTERRUPT_GATE_386);
	set_idt_gate(14, (dword)isr14, INTERRUPT_GATE_386);
	set_idt_gate(15, (dword)isr15, INTERRUPT_GATE_386);
	set_idt_gate(16, (dword)isr16, INTERRUPT_GATE_386);
	set_idt_gate(17, (dword)isr17, INTERRUPT_GATE_386);
	set_idt_gate(18, (dword)isr18, INTERRUPT_GATE_386);
	set_idt_gate(19, (dword)isr19, INTERRUPT_GATE_386);
	set_idt_gate(20, (dword)isr20, INTERRUPT_GATE_386);
	set_idt_gate(21, (dword)isr21, INTERRUPT_GATE_386);
	set_idt_gate(22, (dword)isr22, INTERRUPT_GATE_386);
	set_idt_gate(23, (dword)isr23, INTERRUPT_GATE_386);
	set_idt_gate(24, (dword)isr24, INTERRUPT_GATE_386);
	set_idt_gate(25, (dword)isr25, INTERRUPT_GATE_386);
	set_idt_gate(26, (dword)isr26, INTERRUPT_GATE_386);
	set_idt_gate(27, (dword)isr27, INTERRUPT_GATE_386);
	set_idt_gate(28, (dword)isr28, INTERRUPT_GATE_386);
	set_idt_gate(29, (dword)isr29, INTERRUPT_GATE_386);
	set_idt_gate(30, (dword)isr30, INTERRUPT_GATE_386);
	set_idt_gate(31, (dword)isr31, INTERRUPT_GATE_386);

	/* Install the IRQs */
	set_idt_gate(IRQ0, (dword)irq0, INTERRUPT_GATE_386);
	set_idt_gate(IRQ1, (dword)irq1, INTERRUPT_GATE_386);
	set_idt_gate(IRQ2, (dword)irq2, INTERRUPT_GATE_386);
	set_idt_gate(IRQ3, (dword)irq3, INTERRUPT_GATE_386);
	set_idt_gate(IRQ4, (dword)irq4, INTERRUPT_GATE_386);
	set_idt_gate(IRQ5, (dword)irq5, INTERRUPT_GATE_386);
	set_idt_gate(IRQ6, (dword)irq6, INTERRUPT_GATE_386);
	set_idt_gate(IRQ7, (dword)irq7, INTERRUPT_GATE_386);
	set_idt_gate(IRQ8, (dword)irq8, INTERRUPT_GATE_386);
	set_idt_gate(IRQ9, (dword)irq9, INTERRUPT_GATE_386);
	set_idt_gate(IRQ10, (dword)irq10, INTERRUPT_GATE_386);
	set_idt_gate(IRQ11, (dword)irq11, INTERRUPT_GATE_386);
	set_idt_gate(IRQ12, (dword)irq12, INTERRUPT_GATE_386);
	set_idt_gate(IRQ13, (dword)irq13, INTERRUPT_GATE_386);
	set_idt_gate(IRQ14, (dword)irq14, INTERRUPT_GATE_386);
	set_idt_gate(IRQ15, (dword)irq15, INTERRUPT_GATE_386);

	/* Reserved for user */
	for (int i = 48; i < 255; i++)
		set_idt_gate(i, (dword)isr_not_used, INTERRUPT_GATE_386);
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

void set_idt_gate(int n, dword handler, dword type)
{
	idt[n].offset_low = LOWORD(handler);
	idt[n].seg_sel = KERNEL_CS;

	idt[n].param_cnt = 0;
	idt[n].reserved = 0;
	
	idt[n].access_authority = SEG_PRESENT | SYSTEM_DESCPRITOR | type;
	idt[n].offset_high = HIWORD(handler);
}

void set_idtr()
{
	idtr.base = (dword)&idt;
	idtr.limit = sizeof(idt) - 1;
	load_idtr();
}

void init_exceptions()
{
	set_interrupt_handler(INT_DE, handle_de);
	set_interrupt_handler(INT_DB, handle_db);

	/* int 3 ~ 5 are enabled at user mode */
	set_interrupt_handler(INT_BP, handle_bp);
	idt[INT_BP].access_authority |= DPL_RING3;
	set_interrupt_handler(INT_OF, handle_of);
	idt[INT_OF].access_authority |= DPL_RING3;
	set_interrupt_handler(INT_BR, handle_br);
	idt[INT_BR].access_authority |= DPL_RING3;

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
	set_idtr();				/* Load idtr */

	init_irq();
	init_clock(50);			/* IRQ0: clock, 50ms per tick */
	init_keyboard();		/* IRQ1: keyboard */
	init_hd();				/* Init hard disk */
}
