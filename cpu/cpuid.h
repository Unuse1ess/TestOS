/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2021/4/5 created by MYM.
 *
 *-------------------------------------------------------------*/

#ifndef CPUID_H
#define CPUID_H

#ifndef TYPES_H
#error "types.h" is not included
#endif // !TYPES_H


extern void cpuid(u32 eax, u32 ecx, u32* buffer);


#endif
