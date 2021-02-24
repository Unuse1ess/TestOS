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
extern void return_to_user();

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