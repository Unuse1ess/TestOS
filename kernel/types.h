/*--------------------------------------------------------------
 *						Time: 2020/11/13
 *						Author: MYM
 *--------------------------------------------------------------
 *	This file contains definitions of types used by kernel.
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/13 created by MYM.
 *
 *-------------------------------------------------------------*/

#ifndef TYPE_H
#define TYPE_H

/* From stdint.h */
typedef signed char			int8;
typedef unsigned char		uint8;
typedef short				int16;
typedef unsigned short		uint16;
typedef int					int32;
typedef unsigned			uint32;
typedef long long			int64;
typedef unsigned long long	uint64;

typedef uint8				byte;
typedef uint16				word;
typedef uint32				dword;
typedef uint64				qword;


/* From minwindef.h line 202~207 with some modifications. */
#define MAKEWORD(l, h)		((word)(((byte)(((dword)(l)) & 0xff)) | ((word)((byte)(((dword)(h)) & 0xff))) << 8))
#define MAKEDWORD(l, h)		((dword)(((word)(((dword)(l)) & 0xffff)) | ((dword)((word)(((dword)(h)) & 0xffff))) << 16))
#define LOWORD(dw)			((word)(((dword)(dw)) & 0xffff))
#define HIWORD(dw)			((word)((((dword)(dw)) >> 16) & 0xffff))
#define LOBYTE(w)			((byte)(((dword)(w)) & 0xff))
#define HIBYTE(w)			((byte)((((dword)(w)) >> 8) & 0xff))

typedef int BOOL;

#ifndef TRUE
#define TRUE				1			/* May be unsafe */
#endif

#ifndef FALSE
#define FALSE				0
#endif


#ifndef NULL
#define	NULL				(void*)0
#endif

#define CALLBACK


typedef unsigned STATE;

#define OK					0
#define ERROR				((unsigned)-1)


/* Console information */
typedef struct
{
	byte clr_prop;						/* Color property of text */
	byte is_scroll : 1;					/* 0 = clear screen, 1 = scroll screen, when text is full */
	byte is_delete_line : 1;			/* 0 = delete only in line, 1 = delete all, when backspace is pressed */
}VGA_CONSOLE_INFO;



#endif