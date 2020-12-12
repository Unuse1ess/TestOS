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

#ifndef TYPES_H
#error "kernel/types.h" is not included
#endif

#ifndef TASK_H
#error "kernel/task.h" is not included!
#endif


/*	Some words:
 *	ISR: Interrupt Service Routine
 *	IRQ: Interrupt Request
 *	PIC: Programmable Interrupt Controller
 *	ICW: Initialization Command Word
 *	OCW: Operation Command Word
 */

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

/* Called when hard disk is ready */
extern void isr118();

/* System call*/
extern void isr128();

#define INT_DIVERR				0
#define INT_STEP_DEBUG			1
#define INT_NMI					2
#define INT_DEBUG				3
#define INT_OVERFLOW			4
#define INT_BOUND_CHECK			5
#define INT_UNDEFINED_OPCODE	6
#define INT_NO_FPU				7
#define INT_DOUBLE_FAULTS		8
//#define INT_			9
#define INT_INVALID_TSS			10
#define INT_SS_FAULT			11
#define INT_SET_NOT_EXISTS		12
#define INT_GENERAL_PROTECTION	13
#define INT_PAGE_FAULT			14

/* System call */
#define INT_SYSCALL				0x80

/* Map IRQs to corresponding interrupt number */
#define IRQ0 32
#define IRQ1 33
#define IRQ2 34
#define IRQ3 35
#define IRQ4 36
#define IRQ5 37
#define IRQ6 38
#define IRQ7 39
#define IRQ8 40
#define IRQ9 41
#define IRQ10 42
#define IRQ11 43
#define IRQ12 44
#define IRQ13 45
#define IRQ14 46
#define IRQ15 47

typedef void (CALLBACK *ISR_HANDLER)(THREAD_CONTEXT*);

void set_interrupt_handler(byte n, ISR_HANDLER handler);

#endif
