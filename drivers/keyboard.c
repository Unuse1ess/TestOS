#include "keyboard.h"
#include "../drivers/ports.h"
#include "../cpu/idt.h"
#include "../cpu/isr.h"
#include "screen.h"
#include "../include/string.h"
#include "../include/function.h"
#include "../kernel/kernel.h"

#define BACKSPACE 0x0E
#define ENTER 0x1C

#define SC_MAX 57

static char key_buffer[256];

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

void keyboard_callback(INTERRUPT_STACK_REGS regs)
{
	UNUSED(regs);

	/* The PIC leaves us the scancode in port 0x60 */
	byte scancode = port_byte_in(0x60);

	if (scancode > SC_MAX)
		return;
	if (scancode == BACKSPACE)
	{
		//backspace(key_buffer);
		kputchar('\b');
	}
	else if (scancode == ENTER)
	{
		kprint("\n");
		user_input(key_buffer); /* kernel-controlled function */
		key_buffer[0] = '\0';
	}
	else
	{
		kputchar(sc_ascii[(int)scancode]);
		//	append(key_buffer, letter);
	}
}

void init_keyboard()
{
	set_interrupt_handler(INT_IRQ1, keyboard_callback);
}
