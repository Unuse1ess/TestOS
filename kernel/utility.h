/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/14 Created by MYM.
 *
 *-------------------------------------------------------------*/


#ifndef UTILITY_H
#define UTILITY_H

#ifndef TYPES_H
#error "kernel/types.h" is not included
#endif

void* memset_w(word* dst, word value, unsigned word_cnt);

#endif