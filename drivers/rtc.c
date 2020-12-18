/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/12/15 Created by MYM.
 *
 *-------------------------------------------------------------*/

#include "../kernel/types.h"
#include "ports.h"
#include "rtc.h"


#define CMOS_RAM_ADDR 0x70
#define CMOS_RAM_DATA 0x71

#define DISABLE_NMI 0x80


static byte bcd_to_binary(byte bcd);
static byte cmos_read(byte addr);


void get_system_time(SYSTEM_TIME* sys_time)
{
	sys_time->year = bcd_to_binary(cmos_read(9));
	sys_time->month = bcd_to_binary(cmos_read(8));
	sys_time->day = bcd_to_binary(cmos_read(7));
	sys_time->hour = bcd_to_binary(cmos_read(4));
	sys_time->minute = bcd_to_binary(cmos_read(2));
	sys_time->second = bcd_to_binary(cmos_read(0));
}

static byte cmos_read(byte addr)
{
	port_byte_out(CMOS_RAM_ADDR, DISABLE_NMI | addr);

	return port_byte_in(CMOS_RAM_DATA);
}

static byte bcd_to_binary(byte bcd)
{
	return (bcd >> 4) * 10 + (bcd & 0xf);
}

