# $@ = target file
# $< = first dependency
# $^ = all dependencies

# List all source file
C_SOURCES = $(wildcard kernel/*.c drivers/*.c cpu/*.c libc/*.c)
ASM_SOURCES = $(wildcard libc/*.asm kernel/*.asm cpu/*.asm drivers/*.asm)
# List all C header files
HEADERS = $(wildcard kernel/*.h drivers/*.h cpu/*.h libc/*.h include/*.h)

# Replacement of source files' extend name
C_OBJ = ${C_SOURCES:.c=.o}
ASM_OBJ = ${ASM_SOURCES:.asm=.o}
# All the object files
OBJ = ${C_OBJ} ${ASM_OBJ}

# compilor and debugger
CC = gcc
GDB = gdb
# -g: Use debugging symbols in gcc
CFLAGS = -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs \
#		 -Wall -Wextra -Werror

# First rule is run by default
os-image.bin: boot/boot.bin kernel.bin
	cat $^ > os-image.bin

kernel.bin: kernel.tmp
	objcopy -O binary $< $@
	rm -rf $<

# cpu/interrupt.o cpu/asm_gdt.o cpu/start_page.o
# Temporary PE file of kernel code.
kernel.tmp: boot/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 -Tdata 0x3000 --section-start .PG_TBL=0x10000 --section-start .apm=0x6000 $^

# Used for debugging purposes
kernel.elf: boot/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 -Tdata 0x3000 --section-start .PG_TBL=0x10000 --section-start .apm=0x6000 $^ 

run: os-image.bin
	qemu-system-i386 -fda os-image.bin

# Open the connection to qemu and load our kernel-object file with symbols
# -d guest_errors,int,cpu_reset
debug: os-image.bin kernel.elf
	qemu-system-i386 -s -fda os-image.bin -d guest_errors &
	${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

# Write the kernel to a floppy image used by bochs
bochs: os-image.bin
	dd if=$< of=D:/Code/OS/boot.img bs=1024 count=100 conv=notrunc
	bochsdbg


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