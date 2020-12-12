#include "../kernel/types.h"
#include "../cpu/seg.h"
#include "task.h"
#include "../cpu/isr.h"
#include "../cpu/idt.h"
#include "../drivers/clock.h"
#include "../drivers/screen.h"
#include "sys_call.h"


typedef dword (*SYS_SRV_ROUTINE)(dword);


/* System service table */
SYS_SRV_ROUTINE sys_srv_tbl[] =
{
	(SYS_SRV_ROUTINE)sys_print_screen,
	(SYS_SRV_ROUTINE)sys_get_tick,
	NULL,
};

/* regs->eax contains the index of function to be invoked in sys_srv_tbl.
 * When it returns from the function, regs->eax should contains the return
 * value, if the function has a return value.
 */
void do_sys_call(THREAD_CONTEXT* regs)
{
	regs->eax = (*sys_srv_tbl[regs->eax])(regs->esp + 4);
}

void init_sys_call()
{
	/* Fill the IDT and ISR table */
	set_idt_gate(INT_SYSCALL, (dword)isr128);
	/* Let code in user mode able to jump to kernel */
	idt[INT_SYSCALL].access_authority |= DPL_RING3;
	set_interrupt_handler(INT_SYSCALL, do_sys_call);
}
