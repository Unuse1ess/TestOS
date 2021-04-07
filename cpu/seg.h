/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/15 Created by MYM.
 * 
 *-------------------------------------------------------------*/

#ifndef SEG_H
#define SEG_H

#ifndef TYPES_H
#error "kernel/types.h is not included"
#endif


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
#define NUM_OF_GDT_DESC 16

 /* Kernel's segment selectors */
#define KERNEL_CS							0x08			/* #1 in GDT */
#define KERNEL_DS							0x10			/* #2 in GDT */

/* Selector for local task */
#define USER_CS					(RPL_RING3 | TI_LOCAL_DESCRIPTOR)
#define USER_DS					(8 | RPL_RING3 | TI_LOCAL_DESCRIPTOR)

/*										Structure of segment descriptor
 *  63																									0
 *	+-------------------+-----------+-----------+-----------+-----------+-----------+-------------------+
 *	|		BYTE 7		|	BYTE 6	|	BYTE 5	|	BYTE 4	|	BYTE 3	|	BYTE 2	|		BYTE 0~1	|
 *	+-------------------+-----------+-----------+-----------+-----------+-----------+-------------------+
 *	|Segment Base 31~24 |			...			|		Segment Base 23~0			|Segment Limit 15~0	|
 *	+-------------------+-----------------------+-----------------------------------+-------------------+
 * 
 *									Structure of BYTE 6
 *	BYTE 6
 *	+-------------------------------------------------------+
 *	|						 Attributes						|
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
#define SEG_PRESENT							(1ULL << 47)
#define SEG_NOTPRESENT						0

/* Only use ring0 and ring3. */
/* DPL bits, bit 5~6 */
#define DPL_RING0							0
#define DPL_RING1							(0b01ULL << 45)
#define DPL_RING2							(0b10ULL << 45)
#define DPL_RING3							(0b11ULL << 45)

/* S bit, bit 4 */
#define NORMAL_DESCPRITOR					(1ULL << 44)
#define SYSTEM_DESCPRITOR					0

/* Type of segment descriptor, when S = 1 */
#define SEG_EXECUTABLE						(1ULL << 43)
#define SEG_DATA							0
/* Data segment */
#define SEG_DS_EXPAND_DOWN					(1ULL << 42)
#define SEG_DS_READ_WRITE					(1ULL << 41)
#define SEG_DS_READ_ONLY					0
/* Executable segment */
#define SEG_CS_CONFIRMING					(1ULL << 42)
#define SEG_CS_READ_ONLY					(1ULL << 41)
#define SEG_CS_INACCESSIBLE					0

/* Bit 0  */
#define SEG_ACCESSED						(1ULL << 40)
#define SEG_NOT_ACCESSED					0

/* Type of system descriptor, when S = 0 */
/* Undefined 0x0 */
#define AVAILABLE_286TSS					(0x1ULL << 40)
#define LDT_DESCRIPTOR						(0x2ULL << 40)
#define BUSY_286TSS							(0x3ULL << 40)
#define CALL_GATE_286						(0x4ULL << 40)
#define TASK_GATE							(0x5ULL << 40)
#define INTERRUPT_GATE_286					(0x6ULL << 40)		/* D = 0, 16 bits operand */
#define TRAP_GATE_286						(0x7ULL << 40)
/* Undefined 0x8 */
#define AVAILABLE_386TSS					(0x9ULL << 40)
/* Undefined 0xA */
#define BUSY_386TSS							(0xBULL << 40)
#define CALL_GATE_386						(0xCULL << 40)		/* D = 1, 32 bits operand */
/* Undefined 0xD */
#define INTERRUPT_GATE_386					(0xEULL << 40)
#define TRAP_GATE_386						(0xFULL << 40)

/* Macros for segment descriptor's attribute */
/* Granularity of segment limit */
#define	SA_COUNT_BY_4KB						(1ULL << 55)
#define	SA_COUNT_BY_BYTE					0


/* D/B bit, bit 14 in property */
/* When it is in executable code segment or stack segment */
#define SA_32BITS							(1ULL << 54)
#define SA_16BITS							0

/* When it is in expand-down data segment */
#define SA_UPPERBOUND_4GB					(1ULL << 54)
#define SA_UPPERBOUND_64KB					0


#define MAKE_SEG_DESC(seg_base, seg_limit, attr) \
		(u64)(attr) | \
		((u64)((u32)(seg_base) & 0xFF000000)) << 32 | \
		((u64)((u32)(seg_base) & 0x00FFFFFF)) << 16 | \
		((u64)((u32)(seg_limit) & 0x0000FFFF)) | \
		((u64)((u32)(seg_limit) & 0x000F0000)) << 32

#define MAKE_GATE_DESC(seg_sel, offset, attr) \
		(u64)(attr) | \
		((u64)((u32)(offset) & 0xFFFF0000)) << 32 | \
		(u64)((u32)(offset) & 0x0000FFFF) | \
		((u64)((u16)(seg_sel)) << 16)


#define TSS_IO_BITMAP_END					0xFF

/* Cancel the alignment */
#pragma pack(push, 1)

/*
Structure of segment descriptor
typedef struct _tagSEGMENT_DESCRIPTOR
{
	u16 seg_limit_low;

	u16 seg_base_low;
	u8 seg_base_mid;

	u8 access_authority;

	u8 seg_limit_high : 4;
	u8 attribute : 4;

	u8 seg_base_high;
}SEGMENT_DESCRIPTOR, * GDT, * LDT;

Structure of gate descriptor
typedef struct
{
	u16 offset_low;
	u16 seg_sel;

	u8 param_cnt : 5;
	u8 reserved : 3;

	u8 access_authority;
	u16 offset_high;
}GATE_DESCRIPTOR, INTERRUPT_DESCRIPTOR, *IDT;
 */

/* Meta structure of GDTR, IDTR */
typedef struct
{
	u16 limit;
	u32* base;
}GDTR, IDTR;


/* Pop previous alignment out */
#pragma pack(pop)


typedef u64 SEGMENT_DESCRIPTOR, * GDT, * LDT;
typedef u64 GATE_DESCRIPTOR, INTERRUPT_DESCRIPTOR, * IDT;


/* Functions implemented in idt.c */
void set_idt_gate(int n, u32 handler);


/* Implemented in gdt.c */
void init_gdt();
u16 add_ldt_descriptor(void* seg_base, u32 seg_limit);
u16 add_tss_descriptor(void* seg_base, u32 seg_limit);
u16 add_global_descriptor(void* seg_base, u32 seg_limit, u64 attr);
u16 add_gate_descriptor(u16 seg_sel, u32 offset, u64 attr);
u32 get_desc_base_addr(u16 sel);
void set_desc_base_addr(u16 sel, void* new_addr);

#endif
