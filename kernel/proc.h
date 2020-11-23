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
 */
#define TASK_EFLAGS			0x0202

#pragma pack(push, 4)

typedef struct
{
	dword gs, fs, es, ds;
	dword edi, esi, ebp, kernel_esp, ebx, edx, ecx, eax;
	dword ret_addr;
	dword int_no, err_code;									/* Interrupt number and error code (if applicable) */
	dword eip, cs, eflags, esp, ss;
}THREAD_CONTEXT;

typedef struct
{
	THREAD_CONTEXT regs;			/* +72 */
	word ldtr;
	SEGMENT_DESCRIPTOR ldt[2];
	dword pid;
	char proc_name[16];
}PROCESS;


#pragma pack(pop)

#ifndef PROC_C
extern PROCESS proc_table[NUM_OF_PROCESS];
extern dword proc_offset;
#endif

/* Implemented in proc_switch.asm */
extern void load_tr(word tss_sel);
extern void restart();

void init_process(dword start_addr);

#endif