/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2021/1/12 Created by MYM.
 *
 *-------------------------------------------------------------*/

#include "types.h"
#include "../drivers/screen.h"

void panic(char* str)
{
	kprint(str);
	while (1);
}