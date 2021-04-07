;-----------------------------------------------------------------------------
;									History
;	Version 0.1:
;		2020/4/6 Created by MYM. Create the boot program for the OS.
;-----------------------------------------------------------------------------


STACK_BASE equ 0x8000

ACTIVATED_PARTITION equ 0x80


[org 0x7C00]
[bits 16]

entry:
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, STACK_BASE
	mov bp, STACK_BASE
	
	mov esi, MBR

not_find:
	cmp dword [esi], ACTIVATED_PARTITION
	je finded
	add esi, 16
	cmp dword [esi], 0xaa55
	je panic
	jmp not_find
	
finded:
	
	
; 
load_partition:
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

	
panic:
	jmp $

; Fill rest of space to 0
times 446-($-$$) db 0

MBR:

; Activated partition table
; Activated sign
db ACTIVATED_PARTITION
; Start of partition, in CHS
db 0			; H = 0
dw 2			; C = 0, S = 2

db 'U'			; FS signiture

; End of partition, in CHS
db 0			; H = 0
dw 2			; C = 0, S = 2

dd 2			; Start at sector 1
dd 1			; Totally 1 sector

; Inactivated parition table
times 48 dd 0

; Magic number of boot sector
dw 0xaa55
