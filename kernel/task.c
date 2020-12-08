/*--------------------------------------------------------------
 *						Time: 2020/11/19
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/21 created by MYM.
 *
 *-------------------------------------------------------------*/

#define TASK_C

#include "types.h"
#include "../cpu/seg.h"
#include "task.h"
#include "../include/stdlib.h"



 /* eflags initial value for a task.
  * This value means,
  * IOPL = 0, IF = 1.
  * Others are default 0.
  * 0x0202 0x3202
  */
#define IOPL_3				0x3000
#define IOPL_0				0x0000

#define TASK_EFLAGS			0x0202


TASK task_table[NUM_OF_TASK];
static TASK_STATE_SEGMENT tss[NUM_OF_TASK];
static dword num_of_task;

TASK* rdy_task;						/* Next task to run */

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

void init_tss(TASK_STATE_SEGMENT* tss_addr)
{
	/* Initialize TSS and TR */
	memset((word*)tss_addr, 0, sizeof(TASK_STATE_SEGMENT) >> 1);

	tss_addr->ss0 = KERNEL_DS;
	tss_addr->io_bitmap_base = sizeof(TASK_STATE_SEGMENT) - 2;		/* No IO bitmap */
	tss_addr->io_bitmap_end = TSS_IO_BITMAP_END;
}

void init_task(dword start_addr)
{
	/* Initialize LDT */
	init_ldt(task_table[0].ldt);

	/* Initialize IDT selector and IDT descriptor */
	task_table[0].ldtr = add_ldt_descriptor((dword)task_table[0].ldt , 2 * sizeof(SEGMENT_DESCRIPTOR));

	/* Initialize segment selector */
	task_table[0].regs.cs = TASK_CS;
	task_table[0].regs.ds =
		task_table[0].regs.es =
		task_table[0].regs.fs =
		task_table[0].regs.gs =
		task_table[0].regs.ss = TASK_DS;
	
	task_table[0].regs.eip = start_addr;
	task_table[0].regs.esp = 0x200000;			/* Should allocated by page */
	task_table[0].regs.eflags = TASK_EFLAGS;

	/* Initialize TSS */
	init_tss(&tss[0]);
	task_table[0].tr = add_tss_descriptor((dword)&tss[0], sizeof(TASK_STATE_SEGMENT));
}
