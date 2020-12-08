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

/* Public API for kernel, run in ring0. */
void clear_screen();
void kprint(char* str);
int kprintf(char* fmt, ...);
int kputchar(int ch);
void scroll_screen(byte exceeded_bytes);
word get_cursor_offset();
void set_cursor_offset(word offset);

#endif