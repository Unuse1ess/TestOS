/*--------------------------------------------------------------
 *						Time: 2020/11/25
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/25 created by MYM.
 *
 *-------------------------------------------------------------*/

#ifndef APM_H
#define APM_H

#include "../kernel/types.h"

#ifndef SIZE_OF_PAGE
#define SIZE_OF_PAGE					1024
#endif

#define ADDR_APM_DATA					0x6000

#define APM_DISABLE						1
#define APM_IN_EFFECT					2
#define APM_NOT_CONNECTED				3
#define APM_RM_NOT_CONNECTED			4
#define APM_16PM_CONNECTED				5
#define APM_16PM_NOT_SUPPORT			6
#define APM_32PM_CONNECTED				7
#define APM_32PM_NOT_SUPPORT			8
#define APM_INVALID_DEV_ID				9
#define APM_INVALID_CX					10
#define APM_INTERFACE_NOT_ENGAGED		11
#define APM_FUNCTION_NOT_SUPPORT		12

typedef struct
{
	/* Initialized by real mode codes */
	word pm_code_seg_base;
	byte err_code;
	byte reserved;
	dword pm_entry_point;
	word rm_code_seg_base;
	word rm_code_seg_length;
	word rm_data_seg_base;
	word rm_data_seg_length;

	/* Initialized by C code */
	word cs_32bits_descriptor;
	word cs_16bits_descriptor;
	word ds_16bits_descriptor;

	word call_gate;
}APM_DATA;


/* Implemented in power_manage.asm */
extern void shutdown();
extern int suspend();
extern int stand_by();
extern void reset();

void init_apm();


#ifndef APM_C
extern APM_DATA apm_data;
#endif

#endif