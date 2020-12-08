/*--------------------------------------------------------------
 *						Time: 2020/11/19
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/21 created by MYM.
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


#define NUM_OF_TASK 1


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
	word io_bitmap_end;
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
	/* Used for interrupts */
	dword int_no, err_code;
	/* Pushed by CPU automatically */
	dword eip, cs, eflags, esp, ss;
}THREAD_CONTEXT;

typedef struct _tagTASK
{
	THREAD_CONTEXT regs;			/* Execute envrionment */
	word ldtr;
	word tr;
	SEGMENT_DESCRIPTOR ldt[2];
}TASK;

#pragma pack(pop)

#ifndef TASK_C
extern TASK* rdy_task;
extern TASK task_table[NUM_OF_TASK];
#endif

/* Implemented in task_switch.asm */
extern void start_task(TASK* task);


/* Implemented in task.c */
void init_task(dword start_addr);
void init_tss(TASK_STATE_SEGMENT* tss_addr);

#endif