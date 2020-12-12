/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/20 Created by MYM.
 *
 *-------------------------------------------------------------*/

#ifndef IDT_H
#define IDT_H

#ifndef SEG_H
#error "cpu/seg.h" is not included
#endif


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

/* Used by OCW2 */
#define EOI 0x20

#ifndef IDT_C
extern INTERRUPT_DESCRIPTOR idt[NUM_OF_INT_DESC];
#endif


void init_interrupts();

#endif