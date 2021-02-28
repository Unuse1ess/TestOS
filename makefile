# This is makefile of TestOS.

# $@ = target file
# $< = first dependency
# $^ = all dependencies

# List all source file
C_SOURCES = $(wildcard kernel/*.c drivers/*.c cpu/*.c libc/*.c)
ASM_SOURCES = $(wildcard libc/*.asm kernel/*.asm kernel/sys_call/*.asm cpu/*.asm drivers/*.asm)
# List all C header files
HEADERS = $(wildcard kernel/*.h drivers/*.h cpu/*.h libc/*.h include/*.h)

# Replacement of source files' extend name
C_OBJ = ${C_SOURCES:.c=.o}
ASM_OBJ = ${ASM_SOURCES:.asm=.o}
# All the object files
OBJ = ${C_OBJ} ${ASM_OBJ}

# Address of section
SECTION_ADDR = -Ttext 0x1000 -Tdata 0x4500 \
				--section-start .idata=0x7000 \
				--section-start .boot=0x7C00 \
				--section-start .PG_TBL=0x8000 \
				--section-start .mmap=0xA000 \
				--section-start .apm=0x500 \
				--section-start .mem=0x600 \
				--section-start .video=0x800

# compilor and debugger
CC = gcc
GDB = gdb
# -g: Use debugging symbols in gcc
CFLAGS = -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs \
#		 -Wall -Wextra -Werror

# First rule is run by default
os-image.bin: boot/boot.bin kernel.bin
	cat $^ > os-image.bin

kernel.bin: kernel.tmp
	objcopy -O binary $< $@
	rm -rf $<

# cpu/interrupt.o cpu/asm_gdt.o cpu/start_page.o
# Temporary PE file of kernel code.
# -b binary  --print-gc-sections
kernel.tmp: boot/kernel_entry.o ${OBJ}
	ld -s -S --gc-sections -o $@ ${SECTION_ADDR} $^

# Used for debugging purposes
kernel.elf: boot/kernel_entry.o ${OBJ}
	ld -o $@ ${SECTION_ADDR} $^ 

run:
	qemu-system-i386 -drive file=../test.img,format=raw,index=0,media=disk
	
bdb:
	bochsdbg

# Open the connection to qemu and load our kernel-object file with symbols
# -d guest_errors,int,cpu_reset
qdb: kernel.elf
	qemu-system-i386 -drive file=../test.img,format=raw,index=0,media=disk -d guest_errors -s &
	${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

	
# Write the kernel to a hard disk image
disk: os-image.bin
	dd if=$< of=D:/Code/OS/test.img bs=512 count=200 conv=notrunc


# To make an object, always compile from its .c
%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

clean:
	rm -rf boot/kernel_entry.o cpu/interupt.o
	rm -rf boot/*.bin *.bin *.elf
	rm -rf ${OBJ}

