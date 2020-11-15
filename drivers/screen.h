/*--------------------------------------------------------------
 *						Time: 2020/11/13
 *						Author: MYM
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/13 created by MYM. Added basic things about screen.
 *
 *-------------------------------------------------------------*/

#ifndef SCREEN_H
#define SCREEN_H

#include "../kernel/types.h"

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

/* Public API for kernel, run in ring0. */
void clear_screen();
void kprint(char* str);
int kprintf(char* fmt, ...);
int kputchar(int ch);
void scroll_screen(uint8 exceeded_bytes);
word get_cursor_offset();
void set_cursor_offset(word offset);

#endif