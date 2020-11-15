;-----------------------------------------------------------------------------
;							Time: 2020/11/12
;							Author: MYM
;-----------------------------------------------------------------------------
; History:
;	Version 0.1:
;		2020/11/12 created by MYM. Create the boot program for the OS.
;-----------------------------------------------------------------------------


; Kernel's address in memory
KERNEL_ADDR			equ		0x1000

; IMPORTANT!
; With the size of the kernel growth,
; the number of the sectors to read should grow either.
SEC_NUM_TO_READ		equ		0x20

; Tell the assembler where the program is.
[org 0x7c00]
[bits 16]

	; 1. Load the kernel into 0x1000.

	; Let es:bx points to kernel's address.
	xor ax, ax
	mov es, ax
	mov bx, KERNEL_ADDR

	; ah = 0x02, read service
	mov ah, 0x02
	; al = 0x10, read 0x10 sectors from floppy
	mov al, SEC_NUM_TO_READ

	; cl = 0x02, start reading from #2 sector
	; ch = 0x00, cylinder 0
	mov cx, 0x0002

	; dl = 0x00, read from #0 drive
	; dh = 0x00, read from the boot floppy
	mov dx, 0x0000

	; Use bios interrupt to help us read the floppy
	; and load the kernel to memory.
	int 0x13

	; There may be some errors, so check whether error occur.
	jc disk_err
	cmp al, SEC_NUM_TO_READ
	jne disk_err

	; 2. Switch to 32-bit protected mode.

	cli							; Clear interrupt flag
	in al, 0x92					; Open address line A20
	or al, 0x02
	out 0x92, al

    lgdt [gdt_descriptor]		; Load the GDT descriptor
    mov eax, cr0
    or eax, 0x1					; Set 32-bit mode bit in cr0
    mov cr0, eax
    jmp dword CODE_SEG:init_pm	; Far jump by using a different segment to clear CPU pipeline

disk_err:

	jmp $

; Definition and initialization of global descriptor table
%include "boot/gdt.asm"

[bits 32]

init_pm:
	; Initialize all the data segment
	mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

	; Initialize kernel's stack
	mov ebp, 0x90000
	mov esp, ebp

	jmp KERNEL_ADDR
	jmp $

; Fill the rest of space to 0
times 510-($-$$) db 0
; Magic number of boot sector
dw 0xaa55
