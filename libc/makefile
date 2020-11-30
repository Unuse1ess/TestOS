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

ctype.o: ctype.c ../include/ctype.h

stdlib.o: stdlib.c ../kernel/types.h

string.o: string.c ../kernel/types.h ../include/string.h ../include/stdarg.h ../include/stdlib.h ../include/ctype.h 

%.o: %.c
	gcc ${CFLAGS} $< -o $@
