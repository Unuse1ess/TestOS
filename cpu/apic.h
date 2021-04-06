/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2021/4/5 created by MYM.
 *
 *-------------------------------------------------------------*/

#ifndef APIC_H
#define APIC_H


/* Physical address of local APIC registers, which are all MMIO */
#define LAPIC_ID							0xFEE00020
#define LAPIC_VERSION						0xFEE00030
#define LAPIC_TPR							0xFEE00080		/* Task Priority Register */
#define LAPIC_APR							0xFEE00090		/* Arbitration Priority Register */
#define LAPIC_PPR							0xFEE000A0		/* Processor Priority Register */
#define LAPIC_EOI							0xFEE000B0
#define LAPIC_SVR							0xFEE000F0		/* Spurious Interrupt Vector Register */
#define LAPIC_IN_SERVICE					0xFEE00100
#define LAPIC_TRIGGER_MODE					0xFEE00180
#define LAPIC_INTERRUPT_REQUEST				0xFEE00200
#define LAPIC_ERROR_STATUS					0xFEE00280
#define LAPIC_ICR_LOW						0xFEE00300
#define LAPIC_ICR_HIGH						0xFEE00310
#define LAPIC_LVT_TIMER						0xFEE00320
#define LAPIC_LVT_THERMAL_SENSOR			0xFEE00330
#define LAPIC_LVT_PMCR						0xFEE00340		/* Performance Monitoring Counters */
#define LAPIC_LVT_LINT0						0xFEE00350
#define LAPIC_LVT_LINT1						0xFEE00360
#define LAPIC_LVT_ERROR						0xFEE00370
#define LAPIC_TIMER_INITIAL_COUNT			0xFEE00380
#define LAPIC_TIMER_CURRENT_COUNT			0xFEE00390
#define LAPIC_TIMER_DIVID_CONFIG			0xFEE003F0

u32 get_apic_id();
u32 get_apic_lvt_num();
u32 get_apic_version();

#endif
