/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/25 Created by MYM.
 *
 *-------------------------------------------------------------*/

#define APM_C

#include "../kernel/types.h"
#include "../cpu/seg.h"
#include "screen.h"
#include "apm.h"


/*	Apm data most be at 0x6000 */
__attribute__((section(".apm")))
APM_DATA apm_data;

struct __dummy
{};

extern byte apm_jump_stub[7];

static const char* err_msg[] =
{
	"Power management functionality disabled",
	"Interface connection already in effect",
	"Interface not connected",
	"Real-mode interface not connected",
	"16-bit protected-mode interface already connected",
	"16-bit protected-mode interface not supported",
	"32-bit protected-mode interface already connected",
	"32-bit protected-mode interface not supported",
	"Unrecognized device ID",
	"Invalid parameter value in CX",
	"Interface not engaged",
	"Function not supported",
	"Resume Timer disabled",
};


void init_apm()
{
	/* Check the data filled by real-mode codes */
	if (apm_data.err_code)
	{
		kprintf("Failed to initialize APM.\n");
		kprintf("Error code: %d\n", apm_data.err_code);
		kprintf("Error message: %s.\n", err_msg[apm_data.err_code - 1]);
		
		return;
	}

	/* All of them has length of 64KB and should be ring0. */
	apm_data.cs_32bits_descriptor = add_global_descriptor((void*)(apm_data.pm_code_seg_base << 4), 0x10000,
		SEG_EXECUTABLE | SEG_CS_READ_ONLY | SEG_PRESENT | NORMAL_DESCPRITOR | DPL_RING0,
		SA_COUNT_BY_BYTE | SA_USE_32BITS);

	apm_data.cs_16bits_descriptor = add_global_descriptor((void*)(apm_data.rm_code_seg_base << 4), 0x10000,
		SEG_EXECUTABLE | SEG_CS_READ_ONLY | SEG_PRESENT | NORMAL_DESCPRITOR | DPL_RING0,
		SA_COUNT_BY_BYTE | SA_USE_16BITS);

	apm_data.ds_16bits_descriptor = add_global_descriptor((void*)(apm_data.rm_data_seg_base << 4), 0x10000,
		SEG_DATA | SEG_DS_READ_WRITE | SEG_PRESENT | NORMAL_DESCPRITOR | DPL_RING0,
		SA_COUNT_BY_BYTE | SA_USE_16BITS);

	apm_data.call_gate = add_gate_descriptor(apm_data.cs_32bits_descriptor, apm_data.pm_entry_point,
		SEG_PRESENT | DPL_RING0 | SYSTEM_DESCPRITOR | CALL_GATE_386, 0);

	/* Modify the call gate selector in apm jump stub,
	 * enabling CPU find the correct call gate.
	 */
	*(word*)&apm_jump_stub[5] = apm_data.call_gate;
}

