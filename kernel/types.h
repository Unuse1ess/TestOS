/*--------------------------------------------------------------
 *						Time: 2020/11/13
 *						Author: MYM
 *--------------------------------------------------------------
 *	This file contains definitions of types used by kernel.
 *--------------------------------------------------------------
 * History:
 *	Version 0.1:
 *		2020/11/13 created by MYM. Create the kernel of OS.
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



#ifndef TRUE
#define TRUE				1			/* May be unsafe */
#endif

#ifndef FALSE
#define FALSE				0
#endif

#ifndef NULL
#define	NULL				(void*)0
#endif


/* Meta structure of segment descriptor */
typedef struct
{
	word segment_length_0_15;			/* Segment length bit 0~15 */

	byte segment_base_0_7;				/* Segment base bit 0~23 */
	byte segment_base_8_15;
	byte segment_base_16_23;

	byte type : 4;						/*  */
	byte S : 1;							/*  */
	byte DPL : 2;						/* Descriptor privilege level */
	byte P : 1;							/* Present bit */

	byte segment_length_16_19 : 4;		/* Segment length bit 16~19 */
	byte AVL : 1;						/*  */
	byte reserved : 1;					/* Reserved bit, always 0 */
	byte D_B : 1;						/*  */
	byte G : 1;							/*  */

	byte segment_base_24_31;			/* Segment base bit 24~31 */
}SEGMENT_DESCRIPTOR, *GDT, *LDT;

/* Console information */
typedef struct
{
	byte clr_prop;			/* Color property of text */
	byte is_scroll;			/*  */
}CONSOLE_INFO;



#endif