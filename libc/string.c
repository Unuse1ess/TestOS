/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/13 Created by MYM.
 *-------------------------------------------------------------*/

#include "../kernel/types.h"
#include "../include/string.h"
#include "../include/stdarg.h"
#include "../include/stdlib.h"
#include "../include/ctype.h"

/* itoa() is not a standard C library function! */
char* itoa(PITOA_ARGS pArgs)
{
	static const char table[] = { "0123456789ABCDEF" };
	int i, j, start = 0;

	int value = pArgs->value;
	unsigned radix = pArgs->radix;

	if (pArgs->buffer_size <= 1)
		return pArgs->buffer;
	if (pArgs->radix > 16)
		radix = 16;

	if (value == 0)
	{
		pArgs->buffer[0] = '0';
		pArgs->buffer[1] = 0;
		return pArgs->buffer;
	}

	memset(pArgs->buffer, 0, pArgs->buffer_size);

	/* If value is negative, change it to positive,
	 * and add a negative sign at the front. In this
	 * way, if base is 2, it will not show 2's component.
	 */
	if (pArgs->bSigned && value < 0)
	{
		value = -value;
		pArgs->buffer[0] = '-';
		start = 1;
	}
	
	/* Convert each digit to corresponding character */
	for (i = pArgs->buffer_size - 2, j = value; i >= start && value; i--)
	{
		j = value % radix;
		value = (value - j) / radix;
		pArgs->buffer[i] = table[j];

		/* If upper case is not indicated, change letter to lower case. */
		if (!pArgs->bCapital)
			pArgs->buffer[i] |= 0x20;
	}

	/* Move the string to the front */
	i++;
	for (j = start; i < pArgs->buffer_size; i++, j++)
		pArgs->buffer[j] = pArgs->buffer[i];

	return pArgs->buffer;
}

/* Temporary no bug */
int strlen(char* str)
{
	char* p = str;

	while (*p)
		p++;

	return (int)(p - str);
}

/* Simplified vsnprintf(), just support converting some basic type.
 * sprintf() is not implemented not only because it is unsafe but
 * also vsnprintf() is easier to implement, and vsprintf() is not.
 * Notice that size here refer to the number of bytes of buffer size,
 * including '\0'.
 */
int vsnprintf(char* buffer, unsigned size, char* fmt, va_list args)
{
	unsigned cnt = 0, len = 0;
	unsigned width, fill_in;
	char buf[32] = { 0 };
	void* ptr;
	ITOA_ARGS ia;

	memset(buffer, 0, size);

	if (size <= 1)
		return 0;
	else
		size--;		/* Reserve a bit for '\0' */

	ia.buffer = buf;
	ia.buffer_size = 32;

	while (*fmt && cnt < size)
	{
		ia.bCapital = TRUE;
		ia.bSigned = TRUE;
		ia.radix = 10;

		width = 0;
		fill_in = 0;

		if (*fmt == '%')
		{
			/* TODO: Add number, and make it support ld, lu */
			/* Compare lower case */
		recheck:
			switch (fmt[1] | 0x20)
			{
			case '%':
				*buffer++ = '%';
				cnt++;

				fmt += 2;
				break;

			case 'c':
				/* No need to check the size */
				*buffer++ = (char)va_arg(args, int);
				cnt++;

				fmt += 2;		/* Skip the specifier */
				break;

			case 'b':
				ia.radix = 2;
				goto case_u;

			case 'o':
				ia.radix = 8;
				goto case_u;

			case 'p':
			case 'x':
				ia.radix = 16;
				if (fmt[1] == 'x')
					ia.bCapital = FALSE;

			case_u:
			case 'u':
				ia.bSigned = FALSE;

			case 'd':
				ia.value = va_arg(args, int);

				len = strlen(itoa(&ia));
				if (cnt + len >= size)
					goto buffer_exceeded;
				memcpy(buffer, buf, len);

				buffer += len;
				cnt += len;

				fmt += 2;
				break;

			case 's':
				ptr = va_arg(args, void*);

				len = strlen((char*)ptr);
				if (cnt + len >= size)
					goto buffer_exceeded;
				memcpy(buffer, ptr, len);

				buffer += len;
				cnt += len;

				fmt += 2;
				break;

			//case '-':
			//	width = -1;
			//	fmt++;

			default:
				//if (isdigit(fmt[1]))
				//{
				//	fill_in = ' ';
				//	if (fmt[1] == 0)
				//	{
				//		fill_in = '0';
				//	}
				//	else
				//	{
				//		int i = 1, j;

				//		while (isdigit(fmt[++i]));
				//		j = --i;
				//		for (; i >= 1; i--)
				//			width += fmt[i] - '0';
				//		fmt += j;
				//		for (i = 0; i < width && cnt < size; i++)
				//		{
				//			*buffer++ = fill_in;
				//			cnt++;
				//		}
				//		goto recheck;
				//	}
				//	break;
				//}
				goto not_match;
			}

			continue;
		}

	not_match:
		cnt++;
		*buffer++ = *fmt++;
	}

buffer_exceeded:
	return cnt;
}

int snprintf(char* buffer, unsigned size, char* fmt, ...)
{
	va_list args;
	int ret;

	va_start(args, fmt);
	ret = vsnprintf(buffer, size, fmt, args);
	va_end(args);

	return ret;
}

int strcmp(char* s1, char* s2)
{
	for (; *s1 && *s2; s1++, s2++)
		if (*s1 != *s2)
			return *s1 - *s2;
	return 0;
}