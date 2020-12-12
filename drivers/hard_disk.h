/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/12/3 Created by MYM.
 *
 *-------------------------------------------------------------*/

#ifndef HARD_DISK_H
#define HARD_DISK_H

#ifndef TYPES_H
#error "kernel/types.h" is not included
#endif


void init_hd();
void pio_hd_read_sector(void* buffer, byte count, byte drive, byte sector, word cylinder, byte head);
void pio_hd_write_sector(void* buffer, byte count, byte drive, byte sector, word cylinder, byte head);

#endif