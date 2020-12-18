/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/12/15 Created by MYM.
 *
 *-------------------------------------------------------------*/

#ifndef RTC_H
#define RTC_H

#ifndef TYPES_H
#error "kernel/types.h" is not included
#endif

typedef struct
{
	byte year;
	byte month;
	byte day;
	byte hour;
	byte minute;
	byte second;
}SYSTEM_TIME;

void get_system_time(SYSTEM_TIME* sys_time);

#endif