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

/* Attribute of segment selector */
/* RPL bits */
#define RPL_RING0				0
#define RPL_RING1				1
#define RPL_RING2				2
#define RPL_RING3				3

/* TI bit */
#define TI_LOCAL_DESCRIPTOR		4


/* x86 CPU only has 256 interrupts */
#define NUM_OF_INT_DESC 256

/*	0. NULL
 *	1. Kernel code segment
 *	2. Kernel data segment
 *	3. ...
 */
#define NUM_OF_GDT_DESC 32

 /* Kernel's segment selectors */
#define KERNEL_CS							0x08			/* #1 in GDT */
#define KERNEL_DS							0x10			/* #2 in GDT */

/* Selector for local task */
#define TASK_CS					(RPL_RING3 | TI_LOCAL_DESCRIPTOR)
#define TASK_DS					(8 | RPL_RING3 | TI_LOCAL_DESCRIPTOR)

/*										Structure of segment descriptor
 *  63																									0
 *	+-------------------+-----------+-----------+-----------+-----------+-----------+-------------------+
 *	|		BYTE 7		|	BYTE 6	|	BYTE 5	|	BYTE 4	|	BYTE 3	|	BYTE 2	|		BYTE 1		|
 *	+-------------------+-----------+-----------+-----------+-----------+-----------+-------------------+
 *	|Segment Base 31~24 |			...			|		Segment Base 23~0			|Segment Limit 15~0	|
 *	+-------------------+-----------------------+-----------------------------------+-------------------+
 * 
 *									Structure of BYTE 6
 *	BYTE 6
 *	+---------------+-----------+---------------+-----------+-----------------------+
 *	|	BIT 7		|	BIT 6	|	BIT 5		|	BIT 4	|		BIT 3~0			|	
 *	+---------------+-----------+---------------+-----------+-----------------------+
 *	|		G		|	D/B		|	Reserved	|	AVL		|	Segment Limit 19~16	|
 *	+---------------+-----------+---------------+-----------+-----------------------+
 *	
 *									Structure of BYTE 5
 *	When S = 1 and E = 0:
 *	+-----------+-----------+-----------+---------------+-----------+-----------+-----------+
 *	|	BIT 7	|	BIT 5~6	|	BIT 4	|	BIT 3		|	BIT 2	|	BIT 1	|	BIT 0	|
 *	+-----------+-----------+-----------+---------------+-----------+-----------+-----------+
 *	|	P		|	DPL		|	 S = 1	|	E = 0		|	ED		|	W		|	A		|
 *	+-----------+-----------+-----------+---------------+-----------+-----------+-----------+
 * 
 *	When S = 1 and E = 1:
 *	+-----------+-----------+-----------+---------------+-----------+-----------+-----------+
 *	|	BIT 7	|	BIT 5~6	|	BIT 4	|	BIT 3		|	BIT 2	|	BIT 1	|	BIT 0	|
 *	+-----------+-----------+-----------+---------------+-----------+-----------+-----------+
 *	|	P		|	DPL		|	 S = 1	|	E = 1		|	C		|	R		|	A		|
 *	+-----------+-----------+-----------+---------------+-----------+-----------+-----------+
 *	
 *	When S = 0, it is a system descriptor.
 * 
 *	G: Granularity
 *	D: Default Operation Size
 *	B: Boundary
 *	AVL: Available field
 *	P: Present
 *	DPL: Descriptor Privilege Level
 *	S: System
 *	E: Executable
 *	ED: Expansion Direction
 *	W: Writeable
 *	A: Accessed
 *	C: Comfirming
 *	R: Readable
 */

/* Macros for BYTE 5 */
/* P bit, bit 7 */
#define SEG_PRESENT							0x80
#define SEG_NOTPRESENT						0x00

/* Only use ring0 and ring3. */
/* DPL bits, bit 5~6 */
#define DPL_RING0							0x00
#define DPL_RING1							0x20
#define DPL_RING2							0x40
#define DPL_RING3							0x60

/* S bit, bit 4 */
#define NORMAL_DESCPRITOR					0x10
#define SYSTEM_DESCPRITOR					0x00

/* Type of segment descriptor, when S = 1 */
#define SEG_DATA							0x00
#define SEG_EXECUTABLE						0x08
/* Data segment */
#define SEG_DS_EXPAND_DOWN					0x04
#define SEG_DS_READ_WRITE					0x02
#define SEG_DS_READ_ONLY					0x00
/* Executable segment */
#define SEG_CS_CONFIRMING					0x04
#define SEG_CS_READ_ONLY					0x02
#define SEG_CS_INACCESSIBLE					0x00

/* Bit 0  */
#define SEG_NOT_ACCESSED					0x00
#define SEG_ACCESSED						0x01

/* Type of system descriptor, when S = 0 */
/* Undefined 0x0 */
#define AVAILABLE_286TSS					0x1
#define LDT_DESCRIPTOR						0x2
#define BUSY_286TSS							0x3
#define CALL_GATE_286						0x4
#define TASK_GATE							0x5
#define INTERRUPT_GATE_286					0x6		/* D = 0, 16 bits operand */
#define TRAP_GATE_286						0x7
/* Undefined 0x8 */
#define AVAILABLE_386TSS					0x9
/* Undefined 0xA */
#define BUSY_386TSS							0xB
#define CALL_GATE_386						0xC		/* D = 1, 32 bits operand */
/* Undefined 0xD */
#define INTERRUPT_GATE_386					0xE
#define TRAP_GATE_386						0xF

/* Macros for segment descriptor's attribute */
/* Granularity of segment limit */
#define	COUNT_BY_4KB						0x08
#define	COUNT_BY_BYTE						0x00


/* D/B bit, bit 14 in property */
/* When it is in executable code segment */
#define USE_32BITS_OPERAND					0x04
#define USE_16BITS_OPERAND					0x00

/* When it is in expand-down data segment */
#define UPPERBOUND_4GB						0x04
#define UPPERBOUND_64KB						0x00

/* When it is describing statck segment */
#define USE_ESP								0x04
#define USE_SP								0x00


#define TSS_IO_BITMAP_END					0xFF

/* Cancel the alignment */
#pragma pack(push, 1)

/* Structure of segment descriptor */
typedef struct
{
	word seg_limit_low;

	word seg_base_low;
	byte seg_base_mid;

	byte access_authority;

	byte seg_limit_high : 4;
	byte attribute : 4;

	byte seg_base_high;
}SEGMENT_DESCRIPTOR, * GDT, * LDT;

/* Meta structure of GDTR */
typedef struct
{
	word limit;
	dword base;
}GDTR;

/* Structure of interrupt descriptor */
typedef struct
{
	word offset_low;
	word seg_sel;
	byte reserved;
	byte flags;
	word offset_high;
} INTERRUPT_DESCRIPTOR, *IDT;

/* Meta structure of IDTR, is the same as GDTR */
typedef GDTR IDTR;

/* Structure of task-state segment */
typedef struct
{
	dword prev_tss_sel;
	/* High privilege stack */
	dword esp0, ss0;
	dword esp1, ss1;
	dword esp2, ss2;
	/* No need to have esp3 and ss3 */

	dword cr3;
	dword eip;
	dword eflags;

	/* General-purpose registers */
	dword eax, ecx, edx, ebx, esp, ebp, esi, edi;

	/* Segment register */
	/* Higher word is 0. */
	dword es, cs, ss, ds, fs, gs;

	dword ldtr;

	word trap_flag;
	word io_bitmap_base;
	word io_bitmap_end;
} TASK_STATE_SEGMENT;

/* Pop previous alignment out */
#pragma pack(pop)

#ifndef IDT_C
extern INTERRUPT_DESCRIPTOR idt[NUM_OF_INT_DESC];
extern IDTR idtr;
#endif

/* Functions implemented in idt.c */
void set_idt_gate(int n, dword handler);
void set_idt();


#ifndef GDT_C
extern SEGMENT_DESCRIPTOR gdt[NUM_OF_GDT_DESC];
extern GDTR gdtr;
#endif


/* Implemented in gdt.c */
void init_gdt();
word add_ldt_descriptor(dword seg_base, dword seg_limit);
word add_tss_descriptor(dword seg_base, dword seg_limit);


#ifndef TSS_C
extern TASK_STATE_SEGMENT tss;
#endif

void init_tss();

extern void load_tr(word tss_sel);


#endif