;-------------------------------------------------------
;						History
;	Version 0.1:
;		2020/11/22 Created by MYM
;-------------------------------------------------------

KERNEL_STACK_BASE equ 0x90000


; Structure of THREAD_CONTEXT
STACK_BASE		equ					0
GSREG			equ	STACK_BASE
FSREG			equ	GSREG			+ 4
ESREG			equ	FSREG			+ 4
DSREG			equ	ESREG			+ 4
EDIREG			equ	DSREG			+ 4
ESIREG			equ	EDIREG			+ 4
EBPREG			equ	ESIREG			+ 4
KERNEL_ESPREG	equ	EBPREG			+ 4
EBXREG			equ	KERNEL_ESPREG	+ 4
EDXREG			equ	EBXREG			+ 4
ECXREG			equ	EDXREG			+ 4
EAXREG			equ	ECXREG			+ 4
INT_NUM			equ EAXREG			+ 4
ERR_CODE		equ INT_NUM			+ 4
EIPREG			equ	ERR_CODE		+ 4
CSREG			equ	EIPREG			+ 4
EFLAGSREG		equ	CSREG			+ 4
ESPREG			equ	EFLAGSREG		+ 4
SSREG			equ	ESPREG			+ 4
; End of THREAD_CONTEXT

LDTR			equ	SSREG			+ 4
TR				equ LDTR			+ 2
LDT				equ	TR				+ 2

TSS_ESP0		equ					4

SIZE_OF_THREAD_CONTEXT equ LDTR
SIZE_OF_STACK equ LDTR
