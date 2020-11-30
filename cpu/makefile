# $@ = target file
# $< = first dependency
# $^ = all dependencies

C_SOURCES = $(wildcard *.c)
ASM_SOURCES = $(wildcard *.asm)
C_OBJ = ${C_SOURCES:.c=.o}
ASM_OBJ = ${ASM_SOURCES:.asm=.o}

CFLAGS = -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -ffreestanding -c

all: ${ASM_OBJ} ${C_OBJ}

%.o: %.asm
	nasm $< -f elf -o $@

gdt.o: gdt.c ../kernel/types.h seg.h

idt.o: idt.c ../kernel/types.h seg.h isr.h idt.h ../drivers/ports.h ../drivers/keyboard.h timer.h page.h

isr.o: isr.c isr.h ../drivers/screen.h ../drivers/ports.h

timer.o: timer.c timer.h idt.h ../drivers/ports.h ../drivers/screen.h ../cpu/isr.h ../include/function.h

%.o: %.c
	gcc ${CFLAGS} $< -o $@
