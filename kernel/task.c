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
#include "spin_lock.h"
#include "../include/stdlib.h"



 /* eflags initial value for a task.
  * This value means, IOPL = 0, IF = 1.
  * Others are default 0. IOPL is 0
  * indicates that user programs cannot
  * change IF and using IO instruction.
  */

#define TASK_EFLAGS			0x0202

  /* Virtual address */
#define DEFAULT_EIP		0x400000
#define DEFAULT_ESP		0xA0000000



/* Defined in timer.c */
extern dword tick;

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

SEGMENT_DESCRIPTOR ldt[2];
word ldtr;

void init_context(THREAD* thread);


void init_ldt()
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

	ldtr = add_ldt_descriptor(ldt, sizeof(ldt));
	load_ldtr(ldtr);
}

void init_tss()
{
	/* Initialize TSS and TR */
	memset((void*)&tss, 0, sizeof(TASK_STATE_SEGMENT));

	tss.ss0 = KERNEL_DS;
	tss.io_bitmap_base = sizeof(TASK_STATE_SEGMENT);
	tr = add_tss_descriptor(&tss, sizeof(TASK_STATE_SEGMENT) - 1);
	load_tr(tr);
}

/* Only copy caller thread */
//dword sys_fork()
//{
//	PROCESS* proc;
//	THREAD* thread;
//	void* p, * cr3, * old_cr3;
//
//	cr3 = alloc_page(PAGE_SYSTEM);
//	valloc_page((dword)cr3, (dword)cr3, PAGE_SYSTEM | PAGE_PRESENT | PAGE_READ_WRITE);
//	memcpy(cr3, (void*)0xFFC00000, SIZE_OF_PAGE);
//	((PAGE_DIRECTORY_TABLE)cr3)[1023] = MAKE_PDT_ITEM(cr3, PAGE_SYSTEM | PAGE_PRESENT | PAGE_READ_WRITE);
//
//	/* Switch cr3 to modify its user space easily */
//	old_cr3 = get_cr3();
//	set_cr3(cr3);
//
//	p = alloc_page(PAGE_SYSTEM);
//	proc = valloc_page((dword)p, (dword)p, PAGE_SYSTEM | PAGE_PRESENT | PAGE_READ_WRITE);
//	memset(proc, 0, SIZE_OF_PAGE);
//
//	proc->pdt_base = (PAGE_DIRECTORY_TABLE)cr3;
//	proc->pid = (dword)proc >> 12;
//	proc->next = pcb;
//	pcb = proc;
//
//	thread = create_thread(proc, get_current_thread()->priority, (void*)get_current_thread()->regs.eip);
//	memcpy(&thread->regs, &get_current_thread()->regs, sizeof(THREAD_CONTEXT));
//	thread->regs.eax = 0;
//	set_cr3(old_cr3);
//
//	return proc->pid;
//}

dword create_proc(void* start_addr, dword priority)
{
	static SPIN_LOCK lock = { 0 };

	PROCESS* proc;
	void* p, * cr3, * old_cr3;

	/* Allocate PDT in kernel space */
	cr3 = alloc_page(PAGE_SYSTEM);
	valloc_page((dword)cr3, (dword)cr3, PAGE_SYSTEM | PAGE_PRESENT | PAGE_READ_WRITE);
	memcpy(cr3, kernel_page_dir_table, SIZE_OF_PAGE);
	((PAGE_DIRECTORY_TABLE)cr3)[1023] = MAKE_PDT_ITEM(cr3, PAGE_SYSTEM | PAGE_PRESENT | PAGE_READ_WRITE);

	/* Switch cr3 to modify its user space easily */
	old_cr3 = get_cr3();
	set_cr3(cr3);

	/* Allocate PCB at kernel space */
	p = alloc_page(PAGE_SYSTEM);
	proc = valloc_page((dword)p, (dword)p, PAGE_SYSTEM | PAGE_PRESENT | PAGE_READ_WRITE);
	memset(proc, 0, SIZE_OF_PAGE);

	proc->pdt_base = (PAGE_DIRECTORY_TABLE)cr3;
	proc->pid = (dword)proc >> 12;
	proc->start_tick = tick;
	proc->next = pcb;

	spin_lock(&lock);
	pcb = proc;
	spin_unlock(&lock);

	/* Create main thread */
	create_thread(proc, priority, start_addr);

	set_cr3(old_cr3);

	return proc->pid;
}

THREAD* create_thread(PROCESS* proc, dword priority,void* start_addr)
{
	static SPIN_LOCK lock = { 0 };

	void* p;
	THREAD* thread;

	/* Allocate kernel stack at kernel space */
	p = alloc_page(PAGE_SYSTEM);
	valloc_page((dword)p, (dword)p, PAGE_SYSTEM | PAGE_PRESENT | PAGE_READ_WRITE);
	memset(p, 0, SIZE_OF_PAGE);
	thread = (THREAD*)((dword)p + SIZE_OF_PAGE - sizeof(THREAD));
	thread->kernel_esp = (dword)thread;
	thread->proc = proc;
	thread->count = thread->priority = priority;
	thread->tid = (dword)p >> 12;
	thread->pdt_base = proc->pdt_base;

	spin_lock(&lock);
	thread->all_next = all_tcb;
	all_tcb = thread;
	thread->rdy_next = rdy_tcb;
	rdy_tcb = thread;
	spin_unlock(&lock);

	/* Allocate user stack at user space */
	p = alloc_page(PAGE_USER);
	valloc_page(DEFAULT_ESP - 2 * SIZE_OF_PAGE, (dword)p, PAGE_USER | PAGE_PRESENT | PAGE_READ_WRITE);
	p = alloc_page(PAGE_USER);
	valloc_page(DEFAULT_ESP - SIZE_OF_PAGE, (dword)p, PAGE_USER | PAGE_PRESENT | PAGE_READ_WRITE);

	/* Allocate code page */
	p = alloc_page(PAGE_USER);
	valloc_page(DEFAULT_EIP, (dword)p, PAGE_USER | PAGE_PRESENT | PAGE_READ_ONLY);
	/* Copy codes to virtual memory */
	memcpy((void*)DEFAULT_EIP, start_addr, SIZE_OF_PAGE);

	init_context(thread);
	thread->state = READY;
}

void init_context(THREAD* thread)
{
	/* Construct stack frame */
	*(dword*)((dword)thread - 4) = (dword)return_to_user;
	thread->kernel_esp = ((dword)thread - 20);

	/* Initialize segment selector */
	thread->regs.cs = USER_CS;
	thread->regs.ds =
		thread->regs.es =
		thread->regs.fs =
		thread->regs.gs =
		thread->regs.ss = USER_DS;

	thread->regs.eip = DEFAULT_EIP;
	thread->regs.esp = DEFAULT_ESP;
	thread->regs.eflags = TASK_EFLAGS;
}


dword suspend_thread(TCB* block_queue, dword tid, dword ms)
{
	THREAD* p = rdy_tcb, *thread = NULL, *prev = rdy_tcb;

	while (p)
	{
		if (p->tid == tid)
		{
			thread = p;
			break;
		}
		prev = p;
		p = p->all_next;
	}

	if (thread == NULL)
		return -1;

	if (!block_queue)
		return -1;

	prev->rdy_next = thread->rdy_next;
	thread->rdy_next = NULL;
	thread->rdy_next = *block_queue;
	*block_queue = thread;

	if (ms < 20)
		ms += 20;
	thread->wake_tick = ms == INFINITY ? INFINITY : tick + ms / 20;
	thread->state = BLOCKED;

	if(thread == get_current_thread())
		schedule();

	return 0;
}


dword resume_thread(TCB* block_queue, dword tid)
{
	THREAD* p, * prev, * thread = NULL;

	if (!block_queue)
		return -1;

	p = prev = *block_queue;
	while (p)
	{
		if (p->tid == tid)
		{
			thread = p;
			break;
		}

		prev = p;
		p = p->block_next;
	}

	if (thread == NULL)
		return -1;

	prev->block_next = thread->block_next;
	thread->block_next = NULL;
	thread->rdy_next = rdy_tcb;
	rdy_tcb = thread;

	thread->state = READY;
}


/*
void do_wake_up()
{
	THREAD* thread = block_tcb, *prev;

	while (thread)
	{
		if (thread->wake_tick == tick)
			resume_thread(&block_tcb, thread->tid);
		thread = thread->block_next;
	}
}
*/

/*	Choose the thread that has the highest tick count.
 * If all the threads have the same tick count, choose
 * the thread that is the first to be ready. If all the
 * tick count is 0, add the tick count according to thread's
 * priority and current state.
 */

THREAD* select_thread(TCB* tcb)
{

}

void schedule()
{
	static SPIN_LOCK lock = { 0 };

	THREAD* thread, *next;
	
	if(get_current_thread()->state == READY)
		get_current_thread()->count--;

reschedule:
	thread = rdy_tcb;
	next = rdy_tcb;
	while (thread)
	{
		if (thread->count >= next->count)
			next = thread;
		thread = thread->rdy_next;
	}

	if (!next->count)
	{
		/* All are not available */
		thread = all_tcb;
		while (thread)
		{
			if (thread->state == BLOCKED)
				thread->count >>= 1;
			thread->count += thread->priority;
			thread = thread->all_next;
		}
		goto reschedule;
	}
	switch_to(next);
}
