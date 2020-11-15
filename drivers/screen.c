/*--------------------------------------------------------------
 *						Time: 2020/11/13
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/13 created by MYM. Create the driver of screen.
 *
 *-------------------------------------------------------------*/

#include "../kernel/types.h"
#include "../include/string.h"
#include "../include/stdlib.h"
#include "../include/stdarg.h"
#include "../kernel/utility.h"
#include "ports.h"
#include "screen.h"


 /* Use the VGA ports to get the current cursor position
  * 1. Ask for high byte of the cursor offset (data 14)
  * 2. Ask for low byte (data 15)
  */
word get_cursor_offset()
{
	word offset;

	/* High byte */
	port_byte_out(REG_SCREEN_CTRL, 0x0e);
	offset = port_byte_in(REG_SCREEN_DATA) << 8;

	/* Low byte */
	port_byte_out(REG_SCREEN_CTRL, 0x0f);
	offset |= port_byte_in(REG_SCREEN_DATA);

	/* Position * size of character cell */
	return offset << 1;
}

void set_cursor_offset(word offset)
{
	/* Similar to get_cursor_offset, but instead of reading we write data */
	offset >>= 1;

	/* High byte */
	port_byte_out(REG_SCREEN_CTRL, 14);
	port_byte_out(REG_SCREEN_DATA, (byte)(offset >> 8));
	/* Low byte */
	port_byte_out(REG_SCREEN_CTRL, 15);
	port_byte_out(REG_SCREEN_DATA, (byte)(offset & 0xff));
}

/*	Since the size of video memory can be divided by 4,
 * reset them to 0 by 4-byte is faster.
 */
void clear_screen()
{
	int size = SIZE_OF_VIDEO_MEM;
	int i;
	dword* vidmem = (dword*)VIDEO_ADDRESS;

	for (i = 0; i < size; i++, vidmem++)
		*vidmem = MAKEDWORD(DEFAULT_BG, DEFAULT_BG);

	/* Reset the cursor */
	set_cursor_offset(0);
}

void kprint(char* str)
{
	word offset = get_cursor_offset();
	video_memory vm = VIDEO_ADDRESS + offset;
	byte is_ctrl_ch = FALSE;
	byte x, y;

	for (; *str; vm += 2, str++)
	{
		if (*str == '\n')
		{
			y = GET_OFFSET_Y(offset);

			/* Next line */
			offset = GET_OFFSET(0, y + 1);
			vm = VIDEO_ADDRESS + offset - 2;
			is_ctrl_ch = TRUE;
		}
		else
		{
			offset += 2;
		}

		if (offset >= SIZE_OF_VIDEO_MEM)
		{
			video_memory p = VIDEO_ADDRESS + SIZE_OF_VIDEO_MEM;

			/* Clear the rows below 25, which is out of screen */
			memset_w((word*)p, DEFAULT_BG, SCREEN_MAX_COLS);
			scroll_screen(offset - SIZE_OF_VIDEO_MEM ? offset - SIZE_OF_VIDEO_MEM : 1);

			/* Set pointer of next character*/
			x = GET_OFFSET_X(offset);
			offset = GET_OFFSET(x - 1, SCREEN_MAX_ROWS - 1);
			vm = VIDEO_ADDRESS + offset;
			offset += 2;
		}

		if (is_ctrl_ch)
		{
			is_ctrl_ch = FALSE;
			continue;
		}

		vm[0] = *str;
		vm[1] = WHITE_ON_BLACK;
	}

	set_cursor_offset(offset);
}

/*	Scroll the scree. */
void scroll_screen(uint8 exceeded_bytes)
{
	byte num_of_line = GET_OFFSET_Y(exceeded_bytes) + 1;
	video_memory dst = VIDEO_ADDRESS;
	video_memory src = VIDEO_ADDRESS + num_of_line * SCREEN_MAX_COLS * 2;

	memcpy(dst, src, SIZE_OF_VIDEO_MEM);
}

/* Kernel mode of printf(). It is almost the same as
 * printf(), but can only print at most 127 characters
 * at one time.
 */
int kprintf(char* fmt, ...)
{
	int ret;
	va_list args;
	char buffer[128];

	va_start(args, fmt);
	ret = vsnprintf(buffer, 128, fmt, args);
	va_end(args);

	kprint(buffer);

	return ret;
}
