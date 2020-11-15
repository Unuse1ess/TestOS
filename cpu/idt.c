
#define IDT_C

#include "seg.h"

INTERRUPT_DESCRIPTOR idt[NUM_OF_INTDESC];
IDTR idtr;

void set_idt_gate(int n, dword handler)
{
	idt[n].low_offset = LOWORD(handler);
	idt[n].sel = KERNEL_CS;
	idt[n].always0 = 0;
	idt[n].flags = 0x8E;
	idt[n].high_offset = HIWORD(handler);
}

void set_idt()
{
	idtr.base = (dword)&idt;
	idtr.limit = NUM_OF_INTDESC * sizeof(IDT) - 1;
	/* Don't make the mistake of loading &idt -- always load &idt_reg */
	__asm__ __volatile__("lidtl (%0)" : : "r" (&idtr));
}
