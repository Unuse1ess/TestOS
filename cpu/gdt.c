/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/16 Created by MYM.
 *
 *-------------------------------------------------------------*/

#include "../kernel/types.h"
#include "seg.h"


 /* Implemented in reload_gdtr.asm */
extern void reload_gdtr(GDTR* p);

/* Private varibales */
static SEGMENT_DESCRIPTOR gdt[NUM_OF_GDT_DESC];
static GATE_DESCRIPTOR* gate_desc_tbl;
static GDTR gdtr;
static word avl_gdt_index;


/* Public functions */

/* Reset the gdtr and gdt, and place them to a known place. */
void init_gdt()
{
	avl_gdt_index = 3;

	gdtr.base = (dword)&gdt;
	gdtr.limit = sizeof(gdt) - 1;

	reload_gdtr(&gdtr);
	gate_desc_tbl = (GATE_DESCRIPTOR*)&gdt;
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
		SEG_PRESENT | DPL_RING0 | SYSTEM_DESCPRITOR | LDT_DESCRIPTOR, SA_USE_32BITS);
}

/* Add a TSS descriptor to GDT and return the selector */
word add_tss_descriptor(dword seg_base, dword seg_limit)
{
	return add_global_descriptor(seg_base, seg_limit - 1,
		SEG_PRESENT | DPL_RING0 | SYSTEM_DESCPRITOR | AVAILABLE_386TSS, SA_USE_32BITS);
}

/* Add a call gate to GDT and return the selector */
word add_gate_descriptor(word seg_sel, dword offset, byte authority, byte param_cnt)
{
	if (avl_gdt_index > NUM_OF_GDT_DESC)
		return 0;

	gate_desc_tbl[avl_gdt_index].seg_sel = seg_sel;

	gate_desc_tbl[avl_gdt_index].offset_low = LOWORD(offset);
	gate_desc_tbl[avl_gdt_index].offset_high = HIWORD(offset);

	gate_desc_tbl[avl_gdt_index].param_cnt = param_cnt;
	gate_desc_tbl[avl_gdt_index].access_authority = authority;
	gate_desc_tbl[avl_gdt_index].reserved = 0;

	/* Next available index */
	avl_gdt_index++;

	return (avl_gdt_index - 1) << 3;
}

dword get_descriptor_base_addr(word tss_sel)
{
	word index = tss_sel >> 3;

	return (dword)gdt[index].seg_base_high << 24 |
		(dword)gdt[index].seg_base_mid << 16 |
		(dword)gdt[index].seg_base_low;
}
