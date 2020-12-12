/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/16 Created by MYM.
 *
 *-------------------------------------------------------------*/

#include "../include/ctype.h"


int isalpha(int ch)
{
	return (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z');
}

int isdigit(int ch)
{
	return ch >= '0' && ch <= '9';
}