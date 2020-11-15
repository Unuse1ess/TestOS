# $@ = target file
# $< = first dependency
# $^ = all dependencies

C_SOURCES = $(wildcard kernel/*.c drivers/*.c cpu/*.c libc/*.c)
ASM_SOURCES = $(wildcard libc/*.asm kernel/*.asm)
HEADERS = $(wildcard kernel/*.h drivers/*.h cpu/*.h libc/*.h include/*.h)
# Nice syntax for file extension replacement
C_OBJ = ${C_SOURCES:.c=.o}
ASM_OBJ = ${ASM_SOURCES:.asm=.o}
OBJ = ${C_OBJ} ${ASM_OBJ}

# Change this if your cross-compiler is somewhere else
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

# Temporary PE file of kernel code.
kernel.tmp: boot/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 -Tdata 0x1950 $^

# Used for debugging purposes
kernel.elf: boot/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 -Tdata 0x1950 $^ 

run: os-image.bin
	qemu-system-i386 -fda os-image.bin

# Open the connection to qemu and load our kernel-object file with symbols
debug: os-image.bin kernel.elf
	qemu-system-i386 -s -fda os-image.bin -d guest_errors &
	${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"
	
bochs: os-image.bin
	dd if=$< of=../../../boot.img bs=1024 count=30 conv=notrunc

# Generic rules for wildcards
# To make an object, always compile from its .c
%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

clean:
	rm -rf boot/*.bin os-image.bin *.elf
	rm -rf ${OBJ}