
#include "../kernel/types.h"
#include "../cpu/seg.h"
#include "../kernel/task.h"
#include "../drivers/ports.h"
#include "screen.h"
#include "../cpu/isr.h"
#include "../cpu/idt.h"

#define PIO_BASE_ADDR1 0x1f0
#define PIO_BASE_ADDR2 0x3f0


void hd_request(THREAD_CONTEXT* regs)
{
	kprint("int 0x76\n");
}

void init_hd()
{
	set_idt_gate(0x76, (dword)isr118);
	set_interrupt_handler(0x76, hd_request);
}

void pio_hd_read_sector(void* buffer, byte count, byte drive, byte sector, word cylinder, byte head)
{
	int i;
	unsigned cnt;
	byte state;
	dword* tmp = (dword*)buffer;

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
	port_byte_out(PIO_BASE_ADDR1 + 7, 0x20);

	do
	{
		state = port_byte_in(PIO_BASE_ADDR1 + 7);
	} while (state != 0x58);

	__asm("cli");

	/* Transfer the data in double words each time */
	cnt = count * 128;
	for (i = 0; i < cnt; i++)
		*tmp++ = port_dword_in(PIO_BASE_ADDR1);

	__asm("sti");
}

void pio_hd_write_sector(void* buffer, byte count, byte drive, byte sector, word cylinder, byte head)
{
	int i, j;
	byte state;
	dword* tmp = (dword*)buffer;

	/* Reset hard disk */
	port_byte_out(PIO_BASE_ADDR2 + 6, 4);
	port_byte_out(PIO_BASE_ADDR2 + 6, 0);

	/* Wait until BSY == 0 and DRQ == 0 */
	do
	{
		state = port_byte_in(PIO_BASE_ADDR1 + 7);
	}while (state & 0x88 != 0x88);

	/* Set read command */
	port_byte_out(PIO_BASE_ADDR1 + 1, 0);
	port_byte_out(PIO_BASE_ADDR1 + 2, count);
	port_byte_out(PIO_BASE_ADDR1 + 3, sector);
	port_word_out(PIO_BASE_ADDR1 + 4, cylinder);
	port_byte_out(PIO_BASE_ADDR1 + 6, ((drive & 1) << 5) | (head & 0xf));
	/* Write */
	port_byte_out(PIO_BASE_ADDR1 + 7, 0x30);

	__asm("cli");

	/* Transfer the data in double words each time */
	for (i = 0; i < count; i++)
	{
		for (j = 0; j < 128; j++, tmp++)
			port_dword_out(PIO_BASE_ADDR1, *tmp);

		/* Check whether there is an error */
		state = port_byte_in(PIO_BASE_ADDR1 + 7);
		if (state & 1)
			break;
	}

	__asm("sti");
}
