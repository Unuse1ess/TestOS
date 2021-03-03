/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/21 Created by MYM.
 *
 *-------------------------------------------------------------*/

#ifndef TASK_H
#define TASK_H

#ifndef TYPES_H
#error "kernel/types.h" is not included
#endif
#ifndef SEG_H
#error "cpu/seg.h" is not included
#endif
#ifndef PAGE_H
#error "cpu/page.h" is not included
#endif // !PAGE_H


/* Thread state */
#define READY		0
#define BLOCKED		1


/* Thread priority */
#define PRIORITY_BELOW_NORMAL	2
#define PRIORITY_NORMAL			4
#define PRIORITY_ABOVE_NORMAL	8


#define INFINITY	(-1U)


#pragma pack(push, 1)

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
} TASK_STATE_SEGMENT;

/*	When interrupts happened, esp will points to eip in this structure,
 *	if there is privilege switch.
 */
typedef struct
{
	/* Segment registers */
	dword gs, fs, es, ds;
	/* General purpose registers */
	dword edi, esi, ebp, kernel_esp, ebx, edx, ecx, eax;
	/* Used for ISR */
	dword int_no, err_code;
	/* Pushed by CPU automatically */
	dword eip, cs, eflags, esp, ss;
}THREAD_CONTEXT;


/* Note that it is structure of x87 memory image under 32-bit
 * operating mode, and for those under 16-bit is not like this.
 */
typedef struct
{
	dword cwd;			/* Control word */
	dword swd;			/* Status word */
	dword twd;			/* Tag word */
	dword fip;			/* FPU PC */
	dword fcs;
	dword foo;			/* FPU operand pointer */
	dword fos;			/* FPU operand selector */

	/* FPU has 8 registers in register stack,
	 * and the size of a register is 10 bytes.
	 * This is because FPU supports 80-bit
	 * floating point number. Note that these
	 * registers share with MMX registers.
	 */
	byte data_regs[80];
}x87_CONTEXT;

/* Execution context of x87 FPU, MMX and SSE */
typedef struct
{
	word fcw;
	word fsw;
	word ftw;
	word fop;			/* x87 FPU opcode */

	dword fip;
	dword fcs;
	dword foo;
	dword fos;

	dword mxcsr;
	dword mxcsr_mask;

	union
	{
		byte mm[10];
		byte xmm[16];
	}data_regs[30];
}FLOATING_POINT_CONTEXT;

typedef struct _tagPROCESS
{
	PAGE_DIRECTORY_TABLE pdt_base;
	dword pid;
	dword start_tick;
	struct _tagPROCESS* next;
}PROCESS, *PCB;

typedef struct _tagTHREAD
{
	THREAD_CONTEXT regs;			/* Execute environment */

	PROCESS* proc;					/* Process that the thread belongs to */
	dword kernel_esp;				/* Points to inner of kernel stack */
	PAGE_DIRECTORY_TABLE pdt_base;	/* The same as proc->pdt_base */
	volatile dword nest_num;		/* Count of nested interrupts */

	FLOATING_POINT_CONTEXT fpu_regs;/* Used if fpu is used in the thread */
	dword used_fpu;					/* Indicate if the thread uses FPU */

	dword reserved[2];				/* Used to make fpu_regs aligned at 16-byte boundary */

	dword state;
	dword tid;
	dword count;
	dword priority;

	dword wake_tick;				/* Tell OS when to wake up */

	struct _tagTHREAD* all_next;
	struct _tagTHREAD* rdy_next;
	struct _tagTHREAD* block_next;

	/* Magic number that checking if it is corrupted */
	dword magic;
}THREAD, *TCB;

#pragma pack(pop)


 
/* Implemented in switch.asm */
extern void switch_to(THREAD* thread);
extern void return_from_interrupt();

/* Implemented in loar_tr.asm */
extern void load_tr(word tr);

/* Implemented in load_ldtr.asm */
extern void load_ldtr(word sel);

/* Implemented in task.c */
dword create_proc(void* start_addr, dword priority);
THREAD* create_thread(PROCESS* proc, dword priority, void* start_addr);
void init_tss();
void init_ldt();
void schedule();


#ifndef TASK_C
extern THREAD* rdy_thread;
#endif

#define get_current_process() rdy_thread->proc
#define get_current_thread() rdy_thread


#endif