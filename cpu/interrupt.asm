;-------------------------------------------------------
;						History
;	Version 0.1:
;		2020/11/15 Created by MYM.
;-------------------------------------------------------

%include "kernel/sconst.inc"

global _return_to_user

[bits 32]

; Defined in isr.c
[extern _isr_handler]

; Common ISR codes
_isr_common_stub:
	; Save context in kernel thread's stack.
	; We use esp0 in TSS to make esp points to
	; kernel stack when interrupt happened.
	pushad
	push ds
	push es
	push fs
	push gs

	; Switch to kernel data segment selector.
	; Notice that ss has been already changed to
	; kernel data segment by CPU automatically.
;	mov ax, ss
;	mov ds, ax
;	mov es, ax
;	mov fs, ax
;	mov gs, ax
	
	; esp is now the same as rdy_thread
	call _isr_handler

_return_to_user:
; After every interrupt we need to send an EOI to the PICs
; or they will not send another interrupt again.
	mov ecx, [esp + INT_NUM]
	cmp ecx, 32
	jb not_irq
	cmp ecx, 47
	ja not_irq

	mov al, 0x20

	cmp ecx, 40
	jb not_slave

	out 0xA0, al

not_slave:
	out 0x20, al

not_irq:

	; Return from interrupt
	pop gs
	pop fs
	pop es
	pop ds
	popad

	add esp, 8
	iretd
	
; We don't get information about which interrupt was caller
; when the handler is run, so we will need to have a different handler
; for every interrupt.
; Furthermore, some interrupts push an error code onto the stack but others
; don't, so we will push a dummy error code for those which don't, so that
; we have a consistent stack for all of them.

; First make the ISRs global
global _isr0
global _isr1
global _isr2
global _isr3
global _isr4
global _isr5
global _isr6
global _isr7
global _isr8
global _isr9
global _isr10
global _isr11
global _isr12
global _isr13
global _isr14
global _isr15
global _isr16
global _isr17
global _isr18
global _isr19
global _isr20
global _isr21
global _isr22
global _isr23
global _isr24
global _isr25
global _isr26
global _isr27
global _isr28
global _isr29
global _isr30
global _isr31
; IRQs
global _irq0
global _irq1
global _irq2
global _irq3
global _irq4
global _irq5
global _irq6
global _irq7
global _irq8
global _irq9
global _irq10
global _irq11
global _irq12
global _irq13
global _irq14
global _irq15

; System call
global _isr128

; Used by user
global _isr_not_used

; 0: Divide By Zero Exception
_isr0:
    push 0
    push 0
    jmp _isr_common_stub

; 1: Debug Exception
_isr1:
    push 0
    push 1
    jmp _isr_common_stub

; 2: Non Maskable Interrupt Exception
_isr2:
    push 0
    push 2
    jmp _isr_common_stub

; 3: Int 3 Exception
_isr3:

    push 0
    push 3
    jmp _isr_common_stub

; 4: INTO Exception
_isr4:

    push 0
    push 4
    jmp _isr_common_stub

; 5: Out of Bounds Exception
_isr5:

    push 0
    push 5
    jmp _isr_common_stub

; 6: Invalid Opcode Exception
_isr6:

    push 0
    push 6
    jmp _isr_common_stub

; 7: Coprocessor Not Available Exception
_isr7:

    push 0
    push 7
    jmp _isr_common_stub

; 8: Double Fault Exception (With Error Code!)
_isr8:

    push 8
    jmp _isr_common_stub

; 9: Coprocessor Segment Overrun Exception
_isr9:

    push 0
    push 9
    jmp _isr_common_stub

; 10: Bad TSS Exception (With Error Code!)
_isr10:

    push 10
    jmp _isr_common_stub

; 11: Segment Not Present Exception (With Error Code!)
_isr11:

    push 11
    jmp _isr_common_stub

; 12: Stack Fault Exception (With Error Code!)
_isr12:

    push 12
    jmp _isr_common_stub

; 13: General Protection Fault Exception (With Error Code!)
_isr13:

    push 13
    jmp _isr_common_stub

; 14: Page Fault Exception (With Error Code!)
_isr14:

    push 14
    jmp _isr_common_stub

; 15: Reserved Exception
_isr15:

    push 0
    push 15
    jmp _isr_common_stub

; 16: Floating Point Exception
_isr16:

    push 0
    push 16
    jmp _isr_common_stub

; 17: Alignment Check Exception
_isr17:

    push 0
    push 17
    jmp _isr_common_stub

; 18: Machine Check Exception
_isr18:

    push 0
    push 18
    jmp _isr_common_stub

; 19: Reserved
_isr19:

    push 0
    push 19
    jmp _isr_common_stub

; 20: Reserved
_isr20:

    push 0
    push 20
    jmp _isr_common_stub

; 21: Reserved
_isr21:

    push 0
    push 21
    jmp _isr_common_stub

; 22: Reserved
_isr22:

    push 0
    push 22
    jmp _isr_common_stub

; 23: Reserved
_isr23:

    push 0
    push 23
    jmp _isr_common_stub

; 24: Reserved
_isr24:

    push 0
    push 24
    jmp _isr_common_stub

; 25: Reserved
_isr25:

    push 0
    push 25
    jmp _isr_common_stub

; 26: Reserved
_isr26:

    push 0
    push 26
    jmp _isr_common_stub

; 27: Reserved
_isr27:

    push 0
    push 27
    jmp _isr_common_stub

; 28: Reserved
_isr28:

    push 0
    push 28
    jmp _isr_common_stub

; 29: Reserved
_isr29:

    push 0
    push 29
    jmp _isr_common_stub

; 30: Reserved
_isr30:

    push 0
    push 30
    jmp _isr_common_stub

; 31: Reserved
_isr31:

    push 0
    push 31
    jmp _isr_common_stub

; IRQ handlers
_irq0:
	
	push 0
	push 32
	jmp _isr_common_stub

_irq1:
	
	push 1
	push 33
	jmp _isr_common_stub

_irq2:
	
	push 2
	push 34
	jmp _isr_common_stub

_irq3:
	
	push 3
	push 35
	jmp _isr_common_stub

_irq4:
	
	push 4
	push 36
	jmp _isr_common_stub

_irq5:
	
	push 5
	push 37
	jmp _isr_common_stub

_irq6:
	
	push 6
	push 38
	jmp _isr_common_stub

_irq7:
	
	push 7
	push 39
	jmp _isr_common_stub

_irq8:
	
	push 8
	push 40
	jmp _isr_common_stub

_irq9:
	
	push 9
	push 41
	jmp _isr_common_stub

_irq10:
	
	push 10
	push 42
	jmp _isr_common_stub

_irq11:
	
	push 11
	push 43
	jmp _isr_common_stub

_irq12:
	
	push 12
	push 44
	jmp _isr_common_stub

_irq13:
	
	push 13
	push 45
	jmp _isr_common_stub

_irq14:
	
	push 14
	push 46
	jmp _isr_common_stub

_irq15:
	
	push 15
	push 47
	jmp _isr_common_stub

; System call
_isr128:
	
	push 0
	push 128
	jmp _isr_common_stub

_isr_not_used:
	push 0
	push 255
	jmp _isr_common_stub
