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
static volatile u16 avl_gdt_index;


/* Public functions */

/* Reset the gdtr and gdt, and place them to a known place. */
void init_gdt()
{
	avl_gdt_index = 3;

	gdtr.base = (u32*)&gdt;
	gdtr.limit = sizeof(gdt) - 1;

	reload_gdtr(&gdtr);
	gate_desc_tbl = (GATE_DESCRIPTOR*)&gdt;
}

/* Add a descriptor to GDT and return the selector */
u16 add_global_descriptor(void* seg_base, u32 seg_limit, u64 attr)
{
	if (avl_gdt_index > NUM_OF_GDT_DESC)
		return 0;

	seg_limit--;

	gdt[avl_gdt_index] = MAKE_SEG_DESC(seg_base, seg_limit, attr);

	/* Next available index */
	avl_gdt_index++;

	return (avl_gdt_index - 1) << 3;
}

/* Add a LDT descriptor to GDT and return the selector */
u16 INLINE add_ldt_descriptor(void* seg_base, u32 seg_limit)
{
	return add_global_descriptor(seg_base, seg_limit,
		SEG_PRESENT | DPL_RING0 | SYSTEM_DESCPRITOR | LDT_DESCRIPTOR | SA_32BITS);
}

/* Add a TSS descriptor to GDT and return the selector */
u16 INLINE add_tss_descriptor(void* seg_base, u32 seg_limit)
{
	return add_global_descriptor(seg_base, seg_limit - 1,
		SEG_PRESENT | DPL_RING0 | SYSTEM_DESCPRITOR | AVAILABLE_386TSS | SA_32BITS);
}

/* Add a call gate to GDT and return the selector */
u16 add_gate_descriptor(u16 seg_sel, u32 offset, u64 attr)
{
	if (avl_gdt_index > NUM_OF_GDT_DESC)
		return 0;

	gdt[avl_gdt_index] = MAKE_GATE_DESC(seg_sel, offset, attr);

	/* Next available index */
	avl_gdt_index++;

	return (avl_gdt_index - 1) << 3;
}

/* Get the logical address in the descriptor */
//u32 get_desc_base_addr(u16 sel)
//{
//	u16 index = sel >> 3;
//
//	return (u32)gdt[index].seg_base_high << 24 |
//		(u32)gdt[index].seg_base_mid << 16 |
//		(u32)gdt[index].seg_base_low;
//}
//
///* Set new logical address in the descriptor */
//void set_desc_base_addr(u16 sel, void* new_addr)
//{
//	u16 index = sel >> 3;
//
//	if (index >= avl_gdt_index)
//		return;
//
//	gdt[index].seg_base_low = LOWORD(new_addr);
//	gdt[index].seg_base_mid = LOBYTE(HIWORD(new_addr));
//	gdt[index].seg_base_high = HIBYTE(HIWORD(new_addr));
//}
