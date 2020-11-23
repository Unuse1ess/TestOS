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
#include "../include/stdlib.h"
#include "proc.h"
#include "../cpu/seg.h"


PROCESS proc_table[NUM_OF_PROCESS];
dword proc_offset;						/* Offset to process to be executed in proc_table, count in byte. */

void init_ldt(LDT ldt)
{
	ldt[0].seg_limit_low = 0xffff;
	ldt[0].seg_limit_high = 0xf;

	ldt[0].seg_base_low = 0;
	ldt[0].seg_base_mid = 0;
	ldt[0].seg_base_high = 0;

	ldt[0].access_authority = SEG_PRESENT | DPL_RING3 | NORMAL_DESCPRITOR | SEG_EXECUTABLE | SEG_CS_READ_ONLY;
	ldt[0].attribute = COUNT_BY_4KB | USE_32BITS_OPERAND;

	ldt[1].seg_limit_low = 0xffff;
	ldt[1].seg_limit_high = 0xf;

	ldt[1].seg_base_low = 0;
	ldt[1].seg_base_mid = 0;
	ldt[1].seg_base_high = 0;

	ldt[1].access_authority = SEG_PRESENT | DPL_RING3 | NORMAL_DESCPRITOR | SEG_DATA | SEG_DS_READ_WRITE;
	ldt[1].attribute = COUNT_BY_4KB | USE_32BITS_OPERAND;
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
	proc_table[0].regs.esp = 0x200000;
	proc_table[0].regs.eflags = TASK_EFLAGS;
}