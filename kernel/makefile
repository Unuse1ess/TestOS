# $@ = target file
# $< = first dependency
# $^ = all dependencies

C_SOURCES = $(wildcard *.c)
ASM_SOURCES = $(wildcard *.asm)
C_OBJ = ${C_SOURCES:.c=.o}
ASM_OBJ = ${ASM_SOURCES:.asm=.o}

CFLAGS = -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -ffreestanding -c

all: ${ASM_OBJ} ${C_OBJ}

%.o: %.asm sconst.inc
	nasm $< -f elf -o $@

kernel.o: kernel.c types.h kernel.h proc.h ../drivers/screen.h ../cpu/seg.h ../cpu/page.h ../cpu/idt.h ../include/stdlib.h ../drivers/apm.h ../drivers/ports.h

memory.o: memory.c ../cpu/page.h ../cpu/isr.h ../drivers/screen.h ../kernel/types.h ../include/stdlib.h ../include/function.h

proc.o: proc.c types.h ../include/stdlib.h proc.h ../cpu/seg.h

tss.o: tss.c ../cpu/seg.h utility.h

%.o: %.c
	gcc ${CFLAGS} $< -o $@
