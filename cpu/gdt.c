/*--------------------------------------------------------------
 *						Time: 2020/11/16
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/15 created by MYM.
 *
 *-------------------------------------------------------------*/

#define GDT_C
#include "seg.h"

 /* Implemented in asm_gdt.asm */
extern void reload_gdt(GDTR* p);

SEGMENT_DESCRIPTOR gdt[NUM_OF_SEGDESC];
GDTR gdtr;


/* Reset the gdtr and gdt, and place them to a known place. */
void init_gdt()
{
	gdtr.base = (dword)gdt;
	gdtr.limit = sizeof(gdt) - 1;

	reload_gdt(&gdtr);
}