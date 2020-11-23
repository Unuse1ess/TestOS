/*--------------------------------------------------------------
 *						Time: 2020/11/22
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/22 created by MYM.
 *
 *-------------------------------------------------------------*/

#define TSS_C

#include "../cpu/seg.h"
#include "utility.h"

TASK_STATE_SEGMENT tss;

void init_tss()
{
	/* Initialize TSS and TR */
	memset_w((word*)&tss, 0, sizeof(TASK_STATE_SEGMENT) >> 1);

	tss.ss0 = KERNEL_DS;
	tss.io_bitmap_base = (word)-1;		/* No IO bitmap */

	load_tr(add_tss_descriptor((dword)&tss, sizeof(TASK_STATE_SEGMENT)));
}