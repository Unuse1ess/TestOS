/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/15 Created by MYM.
 *
 *-------------------------------------------------------------*/

#ifndef CLOCK_H
#define CLOCK_H

#ifndef TYPES_H
#error "kernel/types.h" is not included
#endif


void init_clock(dword freq);
dword sys_get_tick();

#endif
