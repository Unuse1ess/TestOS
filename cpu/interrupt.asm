%include "kernel/sconst.inc"

[bits 32]

; Defined in isr.c
[extern _isr_handler]
[extern _irq_handler]

; Defined in tss.c
[extern _tss]

; Defined in proc.c
[extern _proc_table]
[extern _proc_offset]

; Common ISR code
_isr_common_stub:
	sub esp, 4		; Jump over ret_addr
	pushad			; Save CPU state
	push ds
	push es
	push fs
	push gs

	mov ax, ss		; Kernel data segment descriptor
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	
	; Call C handler
	; Notice that C codes assume ds, ss, es are the same and flat.
	call _isr_handler
	
    ; Restore state
	pop ds
	pop es
	pop fs
	pop gs
	popa
	add esp, 12	; Cleans up the pushed error code, pushed ISR number and ret_addr

	sti
	iretd		; Pops CS, EIP, EFLAGS, SS, and ESP

; Common IRQ code. Identical to ISR code except for the 'call' 
; and the 'pop ebx'
_irq_common_stub:
	sub esp, 4
    pusha
	push ds
	push es
	push fs
	push gs

    mov ax, ss
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

;	cmp ax, [esp + 16]				; Change the esp if privilege level is changed
;	je no_change1

;	mov esp, KERNEL_STACK_BASE

no_change1:
    call _irq_handler

;	mov ax, ss
;	cmp ax, [esp + 16]
;	je no_change2

;	mov esp, [_proc_table]
;	add esp, [_proc_offset]
	
no_change2:
;	lea eax, [esp + STACK_TOP]
;	mov dword [_tss + TSS_ESP0], eax

	pop gs
	pop fs
	pop es
	pop ds
    popad
    add esp, 12

    sti
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

; 0: Divide By Zero Exception
_isr0:
    cli
    push byte 0
    push byte 0
    jmp _isr_common_stub

; 1: Debug Exception
_isr1:
    cli
    push byte 0
    push byte 1
    jmp _isr_common_stub

; 2: Non Maskable Interrupt Exception
_isr2:
    cli
    push byte 0
    push byte 2
    jmp _isr_common_stub

; 3: Int 3 Exception
_isr3:
    cli
    push byte 0
    push byte 3
    jmp _isr_common_stub

; 4: INTO Exception
_isr4:
    cli
    push byte 0
    push byte 4
    jmp _isr_common_stub

; 5: Out of Bounds Exception
_isr5:
    cli
    push byte 0
    push byte 5
    jmp _isr_common_stub

; 6: Invalid Opcode Exception
_isr6:
    cli
    push byte 0
    push byte 6
    jmp _isr_common_stub

; 7: Coprocessor Not Available Exception
_isr7:
    cli
    push byte 0
    push byte 7
    jmp _isr_common_stub

; 8: Double Fault Exception (With Error Code!)
_isr8:
    cli
    push byte 8
    jmp _isr_common_stub

; 9: Coprocessor Segment Overrun Exception
_isr9:
    cli
    push byte 0
    push byte 9
    jmp _isr_common_stub

; 10: Bad TSS Exception (With Error Code!)
_isr10:
    cli
    push byte 10
    jmp _isr_common_stub

; 11: Segment Not Present Exception (With Error Code!)
_isr11:
    cli
    push byte 11
    jmp _isr_common_stub

; 12: Stack Fault Exception (With Error Code!)
_isr12:
    cli
    push byte 12
    jmp _isr_common_stub

; 13: General Protection Fault Exception (With Error Code!)
_isr13:
    cli
    push byte 13
    jmp _isr_common_stub

; 14: Page Fault Exception (With Error Code!)
_isr14:
    cli
    push byte 14
    jmp _isr_common_stub

; 15: Reserved Exception
_isr15:
    cli
    push byte 0
    push byte 15
    jmp _isr_common_stub

; 16: Floating Point Exception
_isr16:
    cli
    push byte 0
    push byte 16
    jmp _isr_common_stub

; 17: Alignment Check Exception
_isr17:
    cli
    push byte 0
    push byte 17
    jmp _isr_common_stub

; 18: Machine Check Exception
_isr18:
    cli
    push byte 0
    push byte 18
    jmp _isr_common_stub

; 19: Reserved
_isr19:
    cli
    push byte 0
    push byte 19
    jmp _isr_common_stub

; 20: Reserved
_isr20:
    cli
    push byte 0
    push byte 20
    jmp _isr_common_stub

; 21: Reserved
_isr21:
    cli
    push byte 0
    push byte 21
    jmp _isr_common_stub

; 22: Reserved
_isr22:
    cli
    push byte 0
    push byte 22
    jmp _isr_common_stub

; 23: Reserved
_isr23:
    cli
    push byte 0
    push byte 23
    jmp _isr_common_stub

; 24: Reserved
_isr24:
    cli
    push byte 0
    push byte 24
    jmp _isr_common_stub

; 25: Reserved
_isr25:
    cli
    push byte 0
    push byte 25
    jmp _isr_common_stub

; 26: Reserved
_isr26:
    cli
    push byte 0
    push byte 26
    jmp _isr_common_stub

; 27: Reserved
_isr27:
    cli
    push byte 0
    push byte 27
    jmp _isr_common_stub

; 28: Reserved
_isr28:
    cli
    push byte 0
    push byte 28
    jmp _isr_common_stub

; 29: Reserved
_isr29:
    cli
    push byte 0
    push byte 29
    jmp _isr_common_stub

; 30: Reserved
_isr30:
    cli
    push byte 0
    push byte 30
    jmp _isr_common_stub

; 31: Reserved
_isr31:
    cli
    push byte 0
    push byte 31
    jmp _isr_common_stub

; IRQ handlers
_irq0:
	cli
	push byte 0
	push byte 32
	jmp _irq_common_stub

_irq1:
	cli
	push byte 1
	push byte 33
	jmp _irq_common_stub

_irq2:
	cli
	push byte 2
	push byte 34
	jmp _irq_common_stub

_irq3:
	cli
	push byte 3
	push byte 35
	jmp _irq_common_stub

_irq4:
	cli
	push byte 4
	push byte 36
	jmp _irq_common_stub

_irq5:
	cli
	push byte 5
	push byte 37
	jmp _irq_common_stub

_irq6:
	cli
	push byte 6
	push byte 38
	jmp _irq_common_stub

_irq7:
	cli
	push byte 7
	push byte 39
	jmp _irq_common_stub

_irq8:
	cli
	push byte 8
	push byte 40
	jmp _irq_common_stub

_irq9:
	cli
	push byte 9
	push byte 41
	jmp _irq_common_stub

_irq10:
	cli
	push byte 10
	push byte 42
	jmp _irq_common_stub

_irq11:
	cli
	push byte 11
	push byte 43
	jmp _irq_common_stub

_irq12:
	cli
	push byte 12
	push byte 44
	jmp _irq_common_stub

_irq13:
	cli
	push byte 13
	push byte 45
	jmp _irq_common_stub

_irq14:
	cli
	push byte 14
	push byte 46
	jmp _irq_common_stub

_irq15:
	cli
	push byte 15
	push byte 47
	jmp _irq_common_stub

