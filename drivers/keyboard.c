#include "../kernel/types.h"
#include "../cpu/seg.h"
#include "../kernel/task.h"
#include "../drivers/ports.h"
#include "screen.h"
#include "keyboard.h"
#include "../cpu/isr.h"
#include "../cpu/idt.h"
#include "../include/function.h"


#define BACKSPACE 0x0E
#define ENTER 0x1C

#define SC_MAX 57


static const char* sc_name[] =
{ "ERROR", "Esc", "1", "2", "3", "4", "5", "6",
	"7", "8", "9", "0", "-", "=", "Backspace", "Tab", "Q", "W", "E",
		"R", "T", "Y", "U", "I", "O", "P", "[", "]", "Enter", "Lctrl",
		"A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "'", "`",
		"LShift", "\\", "Z", "X", "C", "V", "B", "N", "M", ",", ".",
		"/", "RShift", "Keypad *", "LAlt", "Spacebar"
};
static const char sc_ascii[] =
{ '?', '?', '1', '2', '3', '4', '5', '6',
	'7', '8', '9', '0', '-', '=', '?', '?', 'Q', 'W', 'E', 'R', 'T', 'Y',
		'U', 'I', 'O', 'P', '[', ']', '?', '?', 'A', 'S', 'D', 'F', 'G',
		'H', 'J', 'K', 'L', ';', '\'', '`', '?', '\\', 'Z', 'X', 'C', 'V',
		'B', 'N', 'M', ',', '.', '/', '?', '?', '?', ' '
};

void keyboard_callback(THREAD_CONTEXT* regs)
{
	UNUSED(regs);

	/* The 8042 leaves us the scancode in port 0x60, the output buffer register */
	byte scancode = port_byte_in(0x60);

	if (scancode > SC_MAX)
		return;
	if (scancode == BACKSPACE)
	{
		kputchar('\b');
	}
	else if (scancode == ENTER)
	{
		kprint("\n");
	}
	else
	{
		kputchar(sc_ascii[(int)scancode]);
	}
}

void init_keyboard()
{
	set_interrupt_handler(IRQ1, keyboard_callback);

	/* Enable keyboard interrupt (IRQ1, at master chip) */
	port_byte_out(0x21, port_byte_in(0x21) & ~2);
}
