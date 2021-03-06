/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/13 Created by MYM.
 *
 *-------------------------------------------------------------*/

#ifndef TYPES_H
#define TYPES_H

/* From stdint.h */
typedef signed char			int8, int8_t;
typedef unsigned char		uint8, uint8_t;
typedef short				int16, int16_t;
typedef unsigned short		uint16, uint16_t;
typedef int					int32, int32_t;
typedef unsigned			uint32, uint32_t;
typedef long long			int64, int64_t;
typedef unsigned long long	uint64, uint64_t;

typedef uint8				byte, BYTE, u8;
typedef uint16				word, WORD, u16;
typedef uint32				dword, DWORD, u32;
typedef uint64				qword, QWORD, u64;


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
#define INLINE inline

#define OK					0
#define ERROR				((unsigned)-1)

#define LIKELY(x) __builtin_expect(!!(x), 1)
#define UNLIKELY(x) __builtin_expect(!!(x), 0)

#endif