/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/12/3 Created by MYM.
 *
 *-------------------------------------------------------------*/

#include "../kernel/types.h"
#include "../cpu/seg.h"
#include "../cpu/page.h"
#include "../kernel/task.h"
#include "../drivers/ports.h"
#include "screen.h"
#include "../cpu/isr.h"
#include "../cpu/idt.h"

#define PIO_BASE_ADDR1 0x1f0
#define PIO_BASE_ADDR2 0x3f0

#define HD_READ_COMMAND 0x20
#define HD_WRITE_COMMAND 0x30

#define SIZE_OF_SECTOR	0x200

static void hd_request();

static BOOL ready;
static TCB hd_block_tcb;
static TCB current;

void init_hd()
{
	ready = FALSE;

	set_interrupt_handler(IRQ14, hd_request);

	/* Enable hard disk interrupt (IRQ14) */
	port_byte_out(0xA1, port_byte_in(0xA1) & ~0x40);
}

/* Only lower 4 bits of number of head is valid */
void pio_hd_read_sector(void* buffer, byte count, byte drive, byte sector, word cylinder, byte head)
{
	int i;
	byte state;

	if (count == 0)
		return;

	/* Reset hard disk */
	port_byte_out(PIO_BASE_ADDR2 + 6, 4);
	port_byte_out(PIO_BASE_ADDR2 + 6, 0);

	/* Wait until BSY == 0 and DRQ == 0 */
	do
	{
		state = port_byte_in(PIO_BASE_ADDR1 + 7);
	}while ((state & 0x80) || (state & 0x08));

	/* Set read command */
	port_byte_out(PIO_BASE_ADDR1 + 1, 0);
	port_byte_out(PIO_BASE_ADDR1 + 2, count);
	port_byte_out(PIO_BASE_ADDR1 + 3, sector);
	port_word_out(PIO_BASE_ADDR1 + 4, cylinder);
	port_byte_out(PIO_BASE_ADDR1 + 6, ((drive & 1) << 5) | (head & 0xf));
	/* Read */
	port_byte_out(PIO_BASE_ADDR1 + 7, HD_READ_COMMAND);

	for (i = 0; i < count; i++)
	{
		/*
		suspend_thread(&hd_block_queue, get_current_thread(), INFINITY);
		*/
		do
		{
		//	state = port_byte_in(PIO_BASE_ADDR1 + 7);
		} while (ready == FALSE);

		port_buffer_in(PIO_BASE_ADDR1, buffer, SIZE_OF_SECTOR);
		buffer = (void*)((dword)buffer + SIZE_OF_SECTOR);
		ready = FALSE;
	}
}

void pio_hd_write_sector(void* buffer, byte count, byte drive, byte sector, word cylinder, byte head)
{
	int i;
	byte state;

	/* Reset hard disk */
	port_byte_out(PIO_BASE_ADDR2 + 6, 4);
	port_byte_out(PIO_BASE_ADDR2 + 6, 0);

	/* Wait until BSY == 0 and DRQ == 0 */
	do
	{
		state = port_byte_in(PIO_BASE_ADDR1 + 7);
	}while ((state & 0x80) || (state & 0x08));

	/* Set read command */
	port_byte_out(PIO_BASE_ADDR1 + 1, 0);
	port_byte_out(PIO_BASE_ADDR1 + 2, count);
	port_byte_out(PIO_BASE_ADDR1 + 3, sector);
	port_word_out(PIO_BASE_ADDR1 + 4, cylinder);
	port_byte_out(PIO_BASE_ADDR1 + 6, ((drive & 1) << 5) | (head & 0xf));
	/* Write */
	port_byte_out(PIO_BASE_ADDR1 + 7, HD_WRITE_COMMAND);

	/* Transfer the data in double words each time */
	for (i = 0; i < count; i++)
	{
		port_buffer_out(PIO_BASE_ADDR1, buffer, SIZE_OF_SECTOR);
		buffer = (void*)((dword)buffer + SIZE_OF_SECTOR);
		ready = FALSE;

		/* Wait for hard disk finished the write operation */
		do
		{
			/* Clear interrupt signal */
		//	state = port_byte_in(PIO_BASE_ADDR1 + 7);
		} while (ready == FALSE);
	}
}

/* Internel function */

static void hd_request()
{
	byte state = port_byte_in(PIO_BASE_ADDR1 + 7);

	kprint("IRQ14\n");
	ready = TRUE;
}
