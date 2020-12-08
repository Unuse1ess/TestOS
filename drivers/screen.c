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
#include "ports.h"
#include "screen.h"
#include "../include/string.h"
#include "../include/stdlib.h"
#include "../include/stdarg.h"
#include "../kernel/utility.h"

 /* Notice that a character on the screen has its
  * corresponding word-size cell in video memory.
  */
typedef byte* video_memory;

#define VIDEO_ADDRESS ((video_memory)0xb8000)

#define SCREEN_MAX_COLS 80
#define SCREEN_MAX_ROWS 25
#define SIZE_OF_VIDEO_MEM (4000U)

/* Get the offset in video memory */
#define GET_OFFSET(x, y) ((word)(((y)* SCREEN_MAX_COLS + (x)) << 1))
/* Get vertical offset on screen */
#define GET_OFFSET_Y(offset) ((byte)((offset) / (SCREEN_MAX_COLS << 1)))
/* Get horizontal offset on screen */
#define GET_OFFSET_X(offset) ((byte)(((offset) - (GET_OFFSET_Y(offset) * SCREEN_MAX_COLS << 1)) >> 1))

/* Screen i/o ports */
#define REG_SCREEN_CTRL 0x3d4
#define REG_SCREEN_DATA 0x3d5

/* Macro for texts' color porperty */
#define TEXT_COLOR(r, g, b) ((byte)((((r) & 1) << 2) | (((g) & 1) << 1) | ((b) & 1)))
#define BG_COLOR(r, g, b) ((byte)((((r) & 1) << 6) | (((g) & 1) << 5) | (((b) & 1) << 4)))

#define HIGH_LIGHTED ((byte)(0x08))
#define BLINK ((byte)(0x80))

#define WHITE_ON_BLACK TEXT_COLOR(1, 1, 1)
#define DEFAULT_BG	MAKEWORD(0, WHITE_ON_BLACK)


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
	port_byte_out(REG_SCREEN_DATA, HIBYTE(offset));
	/* Low byte */
	port_byte_out(REG_SCREEN_CTRL, 15);
	port_byte_out(REG_SCREEN_DATA, LOBYTE(offset));
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
	byte is_print_ch = FALSE;
	byte x, y;

	for (; *str; vm += 2, str++)
	{
		if (*str == '\n')			/* Return is received */
		{
			y = GET_OFFSET_Y(offset);

			/* Set cursor to next line */
			offset = GET_OFFSET(0, y + 1);
			vm = VIDEO_ADDRESS + offset - 2;
		}
		else if (*str == '\b')		/* Backspace is received */
		{
			y = GET_OFFSET_Y(offset);
			do
			{	/* Find a non-null character */
				vm -= 2;
				offset -= 2;
			} while (vm[0] == 0 && vm > VIDEO_ADDRESS);

			/* If still at the same line, delete previous character. */
			/* If not, set the cursor to next position. */
			if (y == GET_OFFSET_Y(offset))
				vm[0] = 0;
			else
				offset += 2;
		}
		else
		{
			offset += 2;
			is_print_ch = TRUE;
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

		if (is_print_ch)
		{
			vm[0] = *str;
			vm[1] = WHITE_ON_BLACK;
			is_print_ch = FALSE;
		}
	}

	set_cursor_offset(offset);
}

/*	Scroll the scree. */
void scroll_screen(byte exceeded_bytes)
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

int kputchar(int ch)
{
	char str[2];

	str[0] = (char)ch;
	str[1] = 0;

	kprint(str);

	return ch;
}