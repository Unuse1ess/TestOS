/*--------------------------------------------------------------
 *						Time: 2020/11/13
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/15 created by MYM.
 *
 *-------------------------------------------------------------*/

#ifndef IDT_H
#define IDT_H

#include "seg.h"
#include "isr.h"


 /* Macros for 8259A, which is a PIC. */
 /* Ports of Master 8259A used by ICW */
#define ICW1_MASTER 0x20
#define ICW2_MASTER 0x21
#define ICW3_MASTER 0x21
#define ICW4_MASTER 0x21

/* Ports of slave 8259A */
#define ICW1_SLAVE 0xA0
#define ICW2_SLAVE 0xA1
#define ICW3_SLAVE 0xA1
#define ICW4_SLAVE 0xA1


/* Ports of master and slave 8259A used for OCW */
#define OCW_MASTER 0x20
#define OCW_SLAVE 0xA0

/* Used by OCW1 */
#define ENABLE_INTERRUPT(org ,irq)		((org) |= (1 << (INT_IRQ##irq - INT_IRQ0)))
#define DISABLE_INTERRUPT(org, irq)		((org) &= ~(1 << (INT_IRQ##irq - INT_IRQ0)))

/* Used by OCW2 */
#define EOI 0x20


void set_interrupt_handler(byte n, ISR_HANDLER handler);
void init_interrupts();

#ifndef IDT_C
extern INTERRUPT_DESCRIPTOR idt[NUM_OF_INTDESC];
extern IDTR idtr;
#endif

#endif