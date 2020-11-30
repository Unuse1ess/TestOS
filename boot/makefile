# $@ = target file
# $< = first dependency
# $^ = all dependencies

# Makefile in boot/

all: boot.bin

boot.bin: boot.asm gdt.asm kernel_entry.asm
	nasm $< -f bin -o $@
