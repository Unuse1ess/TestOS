/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/21 Created by MYM.
 *
 *-------------------------------------------------------------*/

#define TASK_C

#include "types.h"
#include "../cpu/seg.h"
#include "../cpu/page.h"
#include "memory.h"
#include "task.h"
#include "../include/stdlib.h"



 /* eflags initial value for a task.
  * This value means,
  * IOPL = 0, IF = 1.
  * Others are default 0.
  */
#define IOPL_3				0x3000
#define IOPL_0				0x0000

#define TASK_EFLAGS			0x0202

/* Virtual address */
#define DEFAULT_EIP		0x400000
#define DEFAULT_ESP		0xA0000000



#define get_current_process() rdy_thread->proc
#define get_current_thread() rdy_thread


/* Defined in memory.c.
 * Every process's PDT should copy from kernel's one to
 * share the kernel.
 */
extern PAGE_ITEM kernel_page_dir_table[1024];


/* In this OS, we do not use TSS. Therefore, we use
 * a common TSS for all the tasks, and no need to switch tr.
 */
TASK_STATE_SEGMENT tss;
static word tr;

PCB pcb;

/* all_tcb lists all the threads, and
 * rdy_tcb lists all the prepared threads.
 * block_tcb lists threads that blocked itself.
 * Other blocked threads are at corresponding queue.
 */
TCB all_tcb;
TCB rdy_tcb;
TCB block_tcb;
THREAD* rdy_thread;						/* Next task to run */

void init_ldt(LDT ldt)
{
	/* Initialize descriptor for code segment */
	ldt[0].seg_limit_low = 0xffff;
	ldt[0].seg_limit_high = 0xf;

	ldt[0].seg_base_low = 0;
	ldt[0].seg_base_mid = 0;
	ldt[0].seg_base_high = 0;

	ldt[0].access_authority = SEG_PRESENT | DPL_RING3 | NORMAL_DESCPRITOR | SEG_EXECUTABLE | SEG_CS_READ_ONLY;
	ldt[0].attribute = SA_COUNT_BY_4KB | SA_USE_32BITS;

	/* Initialize descriptor for data segment */
	ldt[1].seg_limit_low = 0xffff;
	ldt[1].seg_limit_high = 0xf;

	ldt[1].seg_base_low = 0;
	ldt[1].seg_base_mid = 0;
	ldt[1].seg_base_high = 0;

	ldt[1].access_authority = SEG_PRESENT | DPL_RING3 | NORMAL_DESCPRITOR | SEG_DATA | SEG_DS_READ_WRITE;
	ldt[1].attribute = SA_COUNT_BY_4KB | SA_USE_32BITS;
}

void init_tss()
{
	/* Initialize TSS and TR */
	memset((void*)&tss, 0, sizeof(TASK_STATE_SEGMENT));

	tss.ss0 = KERNEL_DS;
	tr = add_tss_descriptor((dword)&tss, sizeof(TASK_STATE_SEGMENT));
	load_tr(tr);
}

dword sys_fork()
{
}

dword create_proc(void* start_addr)
{
	PROCESS* proc;
	THREAD* thread;
	
	void* p, *old_cr3;

	/* Allocate PDT in kernel space */
	p = alloc_page(PAGE_SYSTEM);
	valloc_page((dword)p, (dword)p, PAGE_SYSTEM | PAGE_PRESENT | PAGE_READ_WRITE);
	memcpy(p, kernel_page_dir_table, SIZE_OF_PAGE);
	((PAGE_DIRECTORY_TABLE)p)[1023] = MAKE_PDT_ITEM(p, PAGE_SYSTEM | PAGE_PRESENT | PAGE_READ_WRITE);

	/* Switch cr3 to modify its PDT easily */
//	old_cr3 = get_cr3();
	set_cr3(p);

	/* Allocate PCB and TCB at kernel space */
	p = alloc_page(PAGE_SYSTEM);
	proc = valloc_page((dword)p, (dword)p, PAGE_SYSTEM | PAGE_PRESENT | PAGE_READ_WRITE);
	memset(proc, 0, SIZE_OF_PAGE);

	proc->pdt_base = (PAGE_DIRECTORY_TABLE)p;
	proc->pid = (dword)proc >> 12;
	proc->next = pcb;
	pcb = proc;

	/* Create main thread and allocate kernel stack at kernel space */
	p = alloc_page(PAGE_SYSTEM);
	valloc_page((dword)p, (dword)p, PAGE_SYSTEM | PAGE_PRESENT | PAGE_READ_WRITE);
	memset(p, 0, SIZE_OF_PAGE);
	thread = (THREAD*)((dword)p + SIZE_OF_PAGE - sizeof(THREAD));
	thread->kernel_esp = (dword)thread;
	thread->proc = proc;
	thread->count = thread->priority = PRIORITY_NORMAL;
	thread->tid = (dword)p >> 12;
	thread->all_next = all_tcb;
	all_tcb = thread;

	/* Allocate user stack at user space */
	p = alloc_page(PAGE_USER);
	valloc_page(DEFAULT_ESP - 2 * SIZE_OF_PAGE, (dword)p, PAGE_USER | PAGE_PRESENT | PAGE_READ_WRITE);
	p = alloc_page(PAGE_USER);
	valloc_page(DEFAULT_ESP - SIZE_OF_PAGE, (dword)p, PAGE_USER | PAGE_PRESENT | PAGE_READ_WRITE);

	/* Allocate code page */
	p = alloc_page(PAGE_USER);
	valloc_page(DEFAULT_EIP, (dword)p, PAGE_USER | PAGE_PRESENT | PAGE_READ_ONLY);
	memcpy((void*)DEFAULT_EIP, start_addr, SIZE_OF_PAGE);

	init_context(thread);
	thread->state = READY;

	return proc->pid;
}

void init_context(THREAD* thread)
{
	/* Initialize LDT */
	init_ldt(thread->ldt);

	/* Initialize IDT selector and IDT descriptor */
	thread->ldtr = add_ldt_descriptor((dword)thread->ldt, 2 * sizeof(SEGMENT_DESCRIPTOR));

	/* Initialize segment selector */
	thread->regs.cs = TASK_CS;
	thread->regs.ds =
		thread->regs.es =
		thread->regs.fs =
		thread->regs.gs =
		thread->regs.ss = TASK_DS;
	
	thread->regs.eip = DEFAULT_EIP;
	thread->regs.esp = DEFAULT_ESP;
	thread->regs.eflags = TASK_EFLAGS;
}

void schedule()
{
	/* TODO: Add schedule algorithm */
	switch_to(all_tcb);
}