/*--------------------------------------------------------------
 *						Time: 2020/11/19
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/21 created by MYM.
 *
 *-------------------------------------------------------------*/

#define PROC_C

#include "types.h"
#include "../cpu/seg.h"
#include "proc.h"
#include "../include/stdlib.h"


PROCESS proc_table[NUM_OF_PROCESS];
TASK_STATE_SEGMENT tss[NUM_OF_PROCESS];

dword num_of_proc;

PROCESS* rdy_proc;						/* Next process to run */

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

void init_process(dword start_addr)
{
	/* Initialize LDT */
	init_ldt(proc_table[0].ldt);

	/* Initialize IDT selector and IDT descriptor */
	proc_table[0].ldtr = add_ldt_descriptor((dword)proc_table[0].ldt , 2 * sizeof(SEGMENT_DESCRIPTOR));

	/* Initialize segment selector */
	proc_table[0].regs.cs = TASK_CS;
	proc_table[0].regs.ds =
		proc_table[0].regs.es =
		proc_table[0].regs.fs =
		proc_table[0].regs.gs =
		proc_table[0].regs.ss = TASK_DS;
	
	proc_table[0].regs.eip = start_addr;
	proc_table[0].regs.esp = 0x200000;			/* Should allocated by page */
	proc_table[0].regs.eflags = TASK_EFLAGS;

	/* Initialize TSS */
	init_tss(&tss[0]);
	proc_table[0].tr = add_tss_descriptor((dword)&tss[0], sizeof(TASK_STATE_SEGMENT));
}
