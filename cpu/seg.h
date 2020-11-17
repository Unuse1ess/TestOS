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


 /* Privilege level */
 /* Only use ring0 and ring3. */
#define RING0					0
#define RING1					1
#define RING2					2
#define RING3					3

/* x86 CPU only has 256 interrupts */
#define NUM_OF_INTDESC 256

/*	0. NULL
 *	1. Kernel code segment
 *	2. Kernel data segment
 *	3. ...
 */
#define NUM_OF_SEGDESC 16

 /* Kernel's segment selectors */
#define KERNEL_CS							0x08			/* #1 in GDT */
#define KERNEL_DS							0x0c			/* #2 in GDT */

/*										Structure of descriptor
 *  63																									0
 *	+-------------------+-----------+-----------+-----------+-----------+-----------+-------------------+
 *	|		BYTE 7		|	BYTE 6	|	BYTE 5	|	BYTE 4	|	BYTE 3	|	BYTE 2	|		BYTE 1		|
 *	+-------------------+-----------+-----------+-----------+-----------+-----------+-------------------+
 *	|Segment Base 24~31 |		Property...		|		Segment Base 0~23			|Segment Limit 0~15	|
 *	+-------------------+-----------------------+-----------------------------------+-------------------+
 * 
 *									Structure of Property
 *	BYTE 6
 *	+---------------+-----------+---------------+-----------+-----------------------+
 *	|	BIT 7		|	BIT 6	|	BIT 5		|	BIT 4	|		BIT 3~0			|	
 *	+---------------+-----------+---------------+-----------+-----------------------+
 *	|		G		|	D/B		|	Reserved	|	AVL		|	Segment Limit 16~19	|
 *	+---------------+-----------+---------------+-----------+-----------------------+
 *	
 *	BYTE 5
 *	+-----------+-----------+-----------+---------------+
 *	|	BIT 7	|	BIT 5~6	|	BIT 4	|	BIT 0~3		|
 *	+-----------+-----------+-----------+---------------+
 *	|	P		|	DPL		|	  S 	|	  TYPE		|
 *	+-----------+-----------+-----------+---------------+
 * 
 */

/* Macros for BYTE 5 and BYTE 6 */
/* P bit, bit 7 */
#define SEG_PRESENT							1
#define SEG_NOTPRESENT						0

/* Only use ring0 and ring3. */
/* DPL bits, bit 5~6 */
#define DPL_RING0							0
#define DPL_RING1							1
#define DPL_RING2							2
#define DPL_RING3							3

/* S bit, bit 4 */
#define NORMAL_DESCPRITOR					1
#define SYS_DESCPRITOR						0

/* Types of descriptor, bit 0~3 of property.
 * Do not use |= operator directly
 */
/* When S = 1 */
#define READ_ONLY							0x0
#define READ_ACCESSED						0x1
#define READ_WRITE							0x2
#define READ_WRITE_ACCESSED					0x3
#define READ_ONLY_EXPAND_DOWN				0x4
#define READ_ONLY_EXPAND_DOWN_ACCESSED		0x5
#define READ_WRITE_EXPAND_DOWN				0x6
#define READ_WRITE_EXPAND_DOWN_ACCESSED		0x7

/* When S = 0 */
/* Undefined 0x0 */
#define AVAILABLE_286TSS					0x1
#define LDT_DESCRIPTOR						0x2
#define BUSY_286TSS							0x3
#define CALL_GATE_286						0x4
#define TASK_GATE							0x5
#define INTERRUPT_GATE_286					0x6
#define TRAP_GATE_286						0x7
/* Undefined 0x8 */
#define AVAILABLE_386TSS					0x9
/* Undefined 0xA */
#define BUSY_386TSS							0xB
#define CALL_GATE_386						0xC
/* Undefined 0xD */
#define INTERRUPT_GATE_386					0xE
#define TRAP_GATE_386						0xF

/* Granularity of segment limit */
#define	LIMIT_IN_BYTE			1
#define	LIMIT_IN_4KB			0


/* D/B bit, bit 14 in property */
/* When it is in executable code segment */
#define USE_32BITS_OPERAND		1
#define USE_16BITS_OPERAND		0

/* When it is in expand-down data segment */
#define UPPERBOUND_4GB			1
#define UPPERBOUND_64KB			0

/* When it is describing statck segment */
#define USE_ESP					1
#define USE_SP					0


/* Cancel the alignment */
#pragma pack(push, 1)

/* Structure of segment descriptor */
typedef struct
{
	byte seg_limit_low;
	dword seg_base_low : 24;

	byte type : 4;
	byte S : 1;
	byte DPL : 2;
	byte P : 1;

	byte seg_limit_high : 4;
	byte AVL : 1;					/* Available for OS, but we do not use. */
	byte reserved : 1;
	byte D_B : 1;
	byte G : 1;						/* Granularity */

	byte seg_base_high;
}SEGMENT_DESCRIPTOR, * GDT, * LDT;

/* Meta structure of GDTR */
typedef struct
{
	word limit;
	dword base;
}GDTR;

/* Structure of interrupt descriptor */
	/* First byte
	 * Bit 7: "Interrupt is present"
	 * Bits 6-5: Privilege level of caller (0=kernel..3=user)
	 * Bit 4: Set to 0 for interrupt gates
	 * Bits 3-0: bits 1110 = decimal 14 = "32 bit interrupt gate" */
typedef struct
{
	word offset_low; /* Lower 16 bits of handler function address */
	word seg_sel; /* Kernel segment selector */
	byte reserved;
	byte flags;
	word offset_high; /* Higher 16 bits of handler function address */
} INTERRUPT_DESCRIPTOR, *IDT;

/* Meta structure of IDTR, same as GDTR */
typedef GDTR IDTR;


#ifndef IDT_C
extern INTERRUPT_DESCRIPTOR idt[NUM_OF_INTDESC];
extern IDTR idtr;
#endif

/* Functions implemented in idt.c */
void set_idt_gate(int n, dword handler);
void set_idt();


#ifndef GDT_C
extern SEGMENT_DESCRIPTOR gdt[NUM_OF_SEGDESC];
#endif

/* Implemented in _gdt.asm */
extern void reload_gdt(GDT gdt_base);


/* Pop previous alignment out */
#pragma pack(pop)

#endif