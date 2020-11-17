/*--------------------------------------------------------------
 *						Time: 2020/11/13
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/15 created by MYM. This header file defines
 * ISR, which is interrupt service routine, or so called
 * interrupt handler, and also defines IRQ, which is interrupt
 * request. In this OS, IRQ0 ~ IRQ15 are mapped to interrupt
 * 0x20 ~ 0x2f. There is also macros for 8259A.
 * 
 *-------------------------------------------------------------*/
#ifndef ISR_H
#define ISR_H

/**/

#include "../kernel/types.h"

/* Interrupt 0x00 ~ 0x1F are definded by CPU, in protect mode */
/* Defined and implemented in interrupt.asm */
extern void isr0();
extern void isr1();
extern void isr2();
extern void isr3();
extern void isr4();
extern void isr5();
extern void isr6();
extern void isr7();
extern void isr8();
extern void isr9();
extern void isr10();
extern void isr11();
extern void isr12();
extern void isr13();
extern void isr14();
extern void isr15();
extern void isr16();
extern void isr17();
extern void isr18();
extern void isr19();
extern void isr20();
extern void isr21();
extern void isr22();
extern void isr23();
extern void isr24();
extern void isr25();
extern void isr26();
extern void isr27();
extern void isr28();
extern void isr29();
extern void isr30();
extern void isr31();

/* IRQ definitions. They can be think as isr32() ~ isr47().*/
extern void irq0();
extern void irq1();
extern void irq2();
extern void irq3();
extern void irq4();
extern void irq5();
extern void irq6();
extern void irq7();
extern void irq8();
extern void irq9();
extern void irq10();
extern void irq11();
extern void irq12();
extern void irq13();
extern void irq14();
extern void irq15();


/* Map IRQs to corresponding  interrupt number */
#define INT_IRQ0 32
#define INT_IRQ1 33
#define INT_IRQ2 34
#define INT_IRQ3 35
#define INT_IRQ4 36
#define INT_IRQ5 37
#define INT_IRQ6 38
#define INT_IRQ7 39
#define INT_IRQ8 40
#define INT_IRQ9 41
#define INT_IRQ10 42
#define INT_IRQ11 43
#define INT_IRQ12 44
#define INT_IRQ13 45
#define INT_IRQ14 46
#define INT_IRQ15 47

/* Macros for 8259A, which is a PIC (Programmable Interrupt Controller). */
/* ICW is initialization command word. */
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

/* OCW is operation control word */
/* Ports of master and slave 8259A used for OCW */
#define OCW_MASTER 0x20
#define OCW_SLAVE 0xA0

/* Used by OCW1 */
#define ENABLE_INTERRUPT(org ,irq)		((org) |= (1 << (INT_IRQ##irq - INT_IRQ0)))
#define DISABLE_INTERRUPT(org, irq)		((org) &= ~(1 << (INT_IRQ##irq - INT_IRQ0)))

/* Used by OCW2 */
#define EOI 0x20


/* Struct which aggregates many registers */
typedef struct
{
	dword ds;										/* Data segment selector */
	dword edi, esi, ebp, esp, ebx, edx, ecx, eax;	/* Pushed by pusha. */
	dword int_no, err_code;							/* Interrupt number and error code (if applicable) */
	dword eip, cs, eflags, useresp, ss;				/* Pushed by the processor automatically */
} registers_t;

void isr_install();
void isr_handler(registers_t r);
void irq_install();

typedef void (CALLBACK *isr_t)(registers_t);
void register_interrupt_handler(byte n, isr_t handler);

#endif
