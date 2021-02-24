;-----------------------------------------------------------------------------
;									History
;	Version 0.1:
;		2020/11/12 Created by MYM. Create the boot program for the OS.
;-----------------------------------------------------------------------------


; Kernel's address in memory
KERNEL_ADDR			equ		0x500
KERNEL_ENTRY_POINT	equ		0x1000

; IMPORTANT!
; It must not greater than 0x3B or it will cover the boot codes!
SEC_NUM_TO_READ		equ		0x3B


; 0H:500H stores APM data
APM_DATA_OFFSET		equ		0x500
; 0H:600H stores memory data
MEM_BLOCK_INFO_OFFSET equ	0x600
; 0H:800H stores VBE data
VBE_DATA_OFFSET		equ		0x800


; Real mode stack base address
RM_CODE_SEG			equ		0x9EE0
RM_STACK_SEG		equ		0x9EC0
RM_STACK_BASE		equ		0x200

PM_CODE_SEG			equ		0x8
PM_DATA_SEG			equ		0x10


[bits 16]

; Tell the assembler where the program is.
[org 0x7c00]
_start:
	; Initialize real mode stack
	xor ax, ax
	mov ss, ax
	mov sp, RM_STACK_BASE
	mov bp, sp

	xor ax, ax
	mov ds, ax
	mov es, ax

	; Load the kernel into 0x1000.
	call load_kernel
	call setup_apm
	call setup_video_mode
	call get_mem_info
	
	; Switch to 32-bit protected mode.
	cli							; Clear interrupt flag
	in al, 0x92					; Open address line A20
	or al, 0x02
	out 0x92, al

    lgdt [gdt_descriptor]		; Load the GDT descriptor
    mov eax, cr0
    or eax, 1					; Set 32-bit mode bit in cr0
    mov cr0, eax
    jmp dword PM_CODE_SEG:init_pm	; Far jump by using a different segment to clear CPU pipeline
	

load_kernel:
	; Let es:bx points to kernel's address.
	mov bx, KERNEL_ADDR
	
	; ah = 0x02, read service
	mov ax, 0x0200 | SEC_NUM_TO_READ

	; cl = 0x02, start reading from #2 sector
	; ch = 0x00, cylinder 0
	mov cx, 0x0002

	; dl = 0x00, read from #0 drive, bit 7 set for hard disk
	; dh = 0x00, head #0
	mov dx, 0x0080
	
	; Use bios interrupt to help us read the hard disk
	; and load the kernel to memory.
	int 0x13

	; There may be some errors, so check whether error occur.
	jc disk_err
	cmp al, SEC_NUM_TO_READ
	jne disk_err
	
	ret
	
disk_err:
	; TODO: Add error check and prompt
	jmp $

setup_apm:
	; Use BIOS interrupt
	mov ax, 0x5303
	xor bx, bx
	int 0x15

	; Store the APM data by filling them into a structure
	movzx eax, ax
	mov es:[APM_DATA_OFFSET + 0], eax
	mov es:[APM_DATA_OFFSET + 4], ebx
	mov es:[APM_DATA_OFFSET + 8], cx
	mov es:[APM_DATA_OFFSET + 10], si
	mov es:[APM_DATA_OFFSET + 12], dx
	mov es:[APM_DATA_OFFSET + 14], di

	jnc apm_no_err
	mov es:[APM_DATA_OFFSET + 2], ah
	
apm_no_err:
	ret

setup_video_mode:
	; Use BIOS interrupt

	mov di, VBE_DATA_OFFSET

	mov ax, 0x4f00
	int 0x10

	cmp ax, 0x4f			; Succeeded if ax == 0x004f
	jne vid_err

	add di, 0x20			; Get the address of vbe_mode_info in kernel
	mov ax, 0x4f01
	mov cx, 0x109
	int 0x10

	cmp ax, 0x4f
	jne vid_err

	jmp vid_err
	mov ax, 0x4f02
	mov bx, 0x109
	int 0x10
	
vid_err:

	ret
	
get_mem_info:
	mov di, MEM_BLOCK_INFO_OFFSET
	xor ebx, ebx

not_finished:
	mov eax, 0x0000e820
	mov ecx, 20
	mov edx, 0x534D4150				; 'SMAP'
	
	int 0x15

	jc mem_check_err
	add di, 20
	test ebx, ebx
	jnz not_finished

mem_check_err:

	ret

; 32-bit protect mode codes
[bits 32]

init_pm:
	; Initialize all the data segment
	mov ax, PM_DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

	; Initialize kernel's stack
	mov ebp, KERNEL_STACK_BASE
	mov esp, ebp

	jmp KERNEL_ENTRY_POINT

; Definition and initialization of global descriptor table
%include "boot/gdt.asm"
%include "kernel/sconst.inc"

; Fill rest of space to 0
times 510-($-$$) db 0
; Magic number of boot sector
dw 0xaa55
