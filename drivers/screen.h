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

#ifndef TYPES_H
#error "kernel/types.h" is not included
#endif

#pragma pack(push, 1)

typedef struct
{
	dword vbe_sig;				/* "VESA" */
	word vbe_ver;
	dword oem_str;				/* Real mode long pointer */
	dword capabilities;
	dword video_mode_ptr;		/* isa vbeFarPtr */
	word TotalMemory;			/* as # of 64KB blocks */
}VBE_INFO;

typedef struct
{
	word mode_attr;
	byte winA_attr, winB_attr;
	word win_granularity;
	word win_size;
	word segA, segB;
	dword func_ptr;				/* Real mode long pointer */
	word pitch;					/* Bytes per scanline */

	word x_res, y_res;			/* Resolution */
	byte x_char_cell, y_char_cell, planes, bpp, banks;
	byte memory_model, bank_size, image_pages;
	byte reserved0;

	byte red_mask_size, red_pos;
	byte green_mask_size, green_pos;
	byte blue_mask_size, blue_pos;
	byte rsv_mask, rsv_pos;
	byte direct_color_attr;

	dword video_mem;			/* LFB (Linear Frame Buffer) address */
	byte reserved1[6];
} VBE_MODE_INFO;

#pragma pack(pop)

/* Public functions */
void init_screen();
void clear_screen();
void kprint(char* str);
int kprintf(char* fmt, ...);
int kputchar(int ch);
void scroll_screen(byte exceeded_bytes);
word get_cursor_offset();
void set_cursor_offset(word offset);

#endif