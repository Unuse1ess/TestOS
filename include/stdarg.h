/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/14 Created by MYM.
 * 
 *-------------------------------------------------------------*/

#ifndef STDARG_H
#define STDARG_H

typedef char* va_list;


/* To be compatible with different machine alignment,
 * however our OS's target platform is just x86.
 */
#define _INTSIZEOF(n)		((sizeof(n) + sizeof(int) - 1) & ~(sizeof(int) - 1))


#define va_start(ap, v)		(ap = (va_list)&(v) + _INTSIZEOF(v))

/* Notice that type of t must not be char, short and float,
 * because the compilor will convert integer type whose size
 * is below 4 to int and convert float to double, when these
 * type are in the argument list.
 */
#define va_arg(ap, t)		(*(t*)((ap += _INTSIZEOF(t)) - _INTSIZEOF(t)))
#define va_end(ap)			ap = (va_list)0


#endif