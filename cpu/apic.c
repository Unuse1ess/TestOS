/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2021/4/5 created by MYM.
 *
 *-------------------------------------------------------------*/

#include "../kernel/types.h"
#include "page.h"
#include "apic.h"


//void init_apic()
//{
//
//}

u32 get_apic_id()
{ return (*(u32*)LAPIC_ID) >> 24; }

u32 get_apic_lvt_num()
{ return ((*(u32*)LAPIC_VERSION) & 0x00FF0000) >> 16; }

u32 get_apic_version()
{ return (*(u32*)LAPIC_VERSION) & 0xFF; }


