/*--------------------------------------------------------------
 *						Time: 2020/11/13
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/13 created by MYM.
 *
 *-------------------------------------------------------------*/

#include "../kernel/types.h"

/* Should be written in assembly */
/* Real size of value is 1 byte. The higher 3 bytes are discarded. */
void* memset(void* dst, int value, unsigned size)
{
	int r = size & 0x03;
	int num = ((byte)value) | (((byte)value) << 8) | (((byte)value) << 16) | (((byte)value) << 24);
	void* ret = dst;

	/* size /= 4; */
	size >>= 2;

	for (; size; size--)
		*((dword*)dst++) = value;

	for (; r; r--)
		*((byte*)dst++) = (byte)value;

	return ret;
}