# $@ = target file
# $< = first dependency
# $^ = all dependencies

C_SOURCES = $(wildcard *.c)
ASM_SOURCES = $(wildcard *.asm)
C_OBJ = ${C_SOURCES:.c=.o}
ASM_OBJ = ${ASM_SOURCES:.asm=.o}

CFLAGS = -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -ffreestanding -c

all:  ${ASM_OBJ} ${C_OBJ}

%.o: %.asm
	nasm $< -f elf -o $@

apm.o: apm.c ../kernel/types.h ../cpu/seg.h screen.h apm.h

keyboard.o: keyboard.c ../drivers/ports.h ../kernel/kernel.h screen.h keyboard.h ../cpu/idt.h ../cpu/isr.h ../include/string.h ../include/function.h

ports.o: ports.c ../kernel/types.h

screen.o: screen.c ../kernel/types.h ports.h screen.h ../include/string.h ../include/stdlib.h ../include/stdarg.h ../kernel/utility.h

%.o: %.c
	gcc ${CFLAGS} $< -o $@