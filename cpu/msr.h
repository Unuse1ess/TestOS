/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2021/2/22 created by MYM.
 *
 *-------------------------------------------------------------*/

#ifndef MSR_H
#define MSR_H

#ifndef TYPES_H
#error "/kernel/types.h" is not included
#endif

/* Some addressses of model specified register */
#define IA32_TIME_STAMP_COUNTER		0x00000010
#define IA32_APIC_BASE				0x0000001B
#define IA32_FEATURE_CONTROL		0x0000003A
#define IA32_SYSENTER_CS			0x00000174
#define IA32_SYSENTER_ESP			0x00000175
#define IA32_SYSENTER_EIP			0x00000176
#define IA32_MISC_ENABLE			0x000001A0
#define IA32_EFER					0xC0000080

/* Implemented in msr.asm */
extern void read_msr(uint32 address, uint64* value);
extern void write_msr(uint32 address, uint32 low, uint32 high);

#endif
