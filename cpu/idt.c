/*

*/

#define IDT_C

#include "seg.h"

INTERRUPT_DESCRIPTOR idt[NUM_OF_INTDESC];
IDTR idtr;

void set_idt_gate(int n, dword handler)
{
	idt[n].offset_low = LOWORD(handler);
	idt[n].seg_sel = KERNEL_CS;
	idt[n].reserved = 0;
	idt[n].flags = 0x8E;
	idt[n].offset_high = HIWORD(handler);
}

void set_idt()
{
	idtr.base = (dword)&idt;
	idtr.limit = NUM_OF_INTDESC * sizeof(IDT) - 1;
	/* Don't make the mistake of loading &idt -- always load &idt_reg */
	__asm__ __volatile__("lidtl (%0)" : : "r" (&idtr));
}
