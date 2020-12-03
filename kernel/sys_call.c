#include "../kernel/types.h"
#include "../cpu/seg.h"
#include "../cpu/idt.h"
#include "../drivers/screen.h"
#include "sys_call.h"


SYS_SRV_ROUTINE sys_srv_tbl[] =
{
	sys_print_screen,
	NULL,
};


void sys_call(THREAD_CONTEXT* regs)
{
	regs->eax = (*sys_srv_tbl[regs->eax])(regs->esp + 4);
}

void init_sys_call()
{
	/* Fill the IDT and ISR table */
	set_idt_gate(INT_SYSCALL, (dword)isr128);
	idt[INT_SYSCALL].access_authority |= DPL_RING3;
	set_interrupt_handler(INT_SYSCALL, sys_call);
}
