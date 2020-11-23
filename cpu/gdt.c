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
extern void reload_gdtr(GDTR* p);

SEGMENT_DESCRIPTOR gdt[NUM_OF_GDT_DESC];
GDTR gdtr;

static word avl_gdt_index;

/* Reset the gdtr and gdt, and place them to a known place. */
void init_gdt()
{
	avl_gdt_index = 3;

	gdtr.base = (dword)&gdt;
	gdtr.limit = sizeof(gdt) - 1;

	reload_gdtr(&gdtr);
}

/* Add a descriptor to GDT and return the selector */
word add_global_descriptor(dword seg_base, dword seg_limit, byte authority, byte attr)
{
	if (avl_gdt_index > NUM_OF_GDT_DESC)
		return 0;

	seg_limit--;

	gdt[avl_gdt_index].seg_limit_low = LOWORD(seg_limit);
	gdt[avl_gdt_index].seg_limit_high = HIWORD(seg_limit) & 0xf;

	gdt[avl_gdt_index].seg_base_low = LOWORD(seg_base);
	gdt[avl_gdt_index].seg_base_mid = LOBYTE(HIWORD(seg_base));
	gdt[avl_gdt_index].seg_base_high = HIBYTE(HIWORD(seg_base));

	gdt[avl_gdt_index].access_authority = authority;
	gdt[avl_gdt_index].attribute = attr;

	/* Next available index */
	avl_gdt_index++;

	return (avl_gdt_index - 1) << 3;
}

/* Add a LDT descriptor to GDT and return the selector */
word add_ldt_descriptor(dword seg_base, dword seg_limit)
{
	return add_global_descriptor(seg_base, seg_limit,
		SEG_PRESENT | DPL_RING0 | SYSTEM_DESCPRITOR | LDT_DESCRIPTOR, 0);
}

/* Add a TSS descriptor to GDT and return the selector */
word add_tss_descriptor(dword seg_base, dword seg_limit)
{
	return add_global_descriptor(seg_base, seg_limit,
		SEG_PRESENT | DPL_RING0 | SYSTEM_DESCPRITOR | AVAILABLE_386TSS, 0);
}