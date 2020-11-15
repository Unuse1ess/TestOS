/*--------------------------------------------------------------
 *						Time: 2020/11/13
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/15 created by MYM. This header file defines
 * basic things of segmentation of protection mode.
 * 
 *-------------------------------------------------------------*/

#ifndef SEG_H
#define SEG_H

#include "../kernel/types.h"

/* x86 CPU only has 256 interrupts */
#define NUM_OF_INTDESC 256

 /* Kernel's segment selectors */
#define KERNEL_CS 0x08

/* Cancel the alignment */
#pragma pack(push, 1)

/* Structure of segment descriptor */
typedef struct
{
	word segment_length_0_15;			/* Segment length bit 0~15 */

	byte segment_base_0_7;				/* Segment base bit 0~23 */
	byte segment_base_8_15;
	byte segment_base_16_23;

	byte type : 4;						/*  */
	byte S : 1;							/*  */
	byte DPL : 2;						/* Descriptor privilege level */
	byte P : 1;							/* Present bit */

	byte segment_length_16_19 : 4;		/* Segment length bit 16~19 */
	byte AVL : 1;						/*  */
	byte reserved : 1;					/* Reserved bit, always 0 */
	byte D_B : 1;						/*  */
	byte G : 1;							/*  */

	byte segment_base_24_31;			/* Segment base bit 24~31 */
}SEGMENT_DESCRIPTOR, * GDT, * LDT;


/* Structure of interrupt descriptor */
typedef struct
{
	word low_offset; /* Lower 16 bits of handler function address */
	word sel; /* Kernel segment selector */
	byte always0;
	/* First byte
	 * Bit 7: "Interrupt is present"
	 * Bits 6-5: Privilege level of caller (0=kernel..3=user)
	 * Bit 4: Set to 0 for interrupt gates
	 * Bits 3-0: bits 1110 = decimal 14 = "32 bit interrupt gate" */
	byte flags;
	word high_offset; /* Higher 16 bits of handler function address */
} INTERRUPT_DESCRIPTOR, * IDT;

/* Meta structure of idtr */
typedef struct
{
	word limit;
	dword base;
} IDTR;

#ifndef IDT_C
extern INTERRUPT_DESCRIPTOR idt[NUM_OF_INTDESC];
extern IDTR idtr;
#endif

/* Functions implemented in idt.c */
void set_idt_gate(int n, dword handler);
void set_idt();


/* Pop previous alignment out */
#pragma pack(pop)

#endif