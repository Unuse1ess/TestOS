/*--------------------------------------------------------------
 *						Time: 2020/11/13
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/13 created by MYM.
 *
 *-------------------------------------------------------------*/

#ifndef STRING_H
#define STRING_H

#include "stdarg.h"

/* Arguments structure for non-standard C library function itoa(). */
typedef struct
{
	int value;
	char* buffer;
	unsigned char radix : 5;
	unsigned char bSigned : 1;
	unsigned char bCapital : 1;
	unsigned char reserved : 1;
	unsigned char buffer_size;
}ITOA_ARGS, *PITOA_ARGS;

char* itoa(PITOA_ARGS pArgs);
int strlen(char* str);
int vsnprintf(char* buffer, unsigned size, char* fmt, va_list args);
int snprintf(char* buffer, unsigned size, char* fmt, ...);
int strcmp(char* s1, char* s2);

#endif