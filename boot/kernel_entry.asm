;-----------------------------------------------------------------------------
;							Time: 2020/11/13
;							Author: MYM
;-----------------------------------------------------------------------------


[bits 32]
; Externel code from C
[extern _kernel_main]

; The address here should be 0x1000, therefore the link option
; should contain -Ttext 0x1000.

; Give the control to kernel
jmp _kernel_main

