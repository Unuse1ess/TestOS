/*--------------------------------------------------------------
 *						Time: 2020/11/19
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/21 created by MYM.
 *
 *-------------------------------------------------------------*/

#ifndef PROC_H
#define PROC_H

#include "types.h"
#include "../cpu/seg.h"

#define NUM_OF_PROCESS 1

/* eflags initial value for a task.
 * This value means,
 * IOPL = 0, IF = 1.
 * Others are default 0.
 * 0x0202
 */

#define IOPL_3				0x3000
#define IOPL_0				0x0000

#define TASK_EFLAGS			0x3202

#pragma pack(push, 1)

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

typedef struct
{
	THREAD_CONTEXT regs;			/* Execute envrionment */
	word ldtr;
	word tr;
	SEGMENT_DESCRIPTOR ldt[2];
	dword pid;
	char proc_name[16];
}PROCESS;


#pragma pack(pop)

#ifndef PROC_C
extern PROCESS proc_table[NUM_OF_PROCESS];
extern TASK_STATE_SEGMENT tss[NUM_OF_PROCESS];
extern PROCESS* rdy_proc;
extern dword num_of_proc;
#endif


/* Implemented in task_switch.asm */
extern void start_process(PROCESS* proc/*, TASK_STATE_SEGMENT* tss*/);


/* Implemented in proc.c */
void init_process(dword start_addr);
void init_tss(TASK_STATE_SEGMENT* tss_addr);

#endif