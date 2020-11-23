/**
 * Read a byte from the specified port
 */

#include "../kernel/types.h"

byte port_byte_in(word port)
{
	byte result;

	/* Inline assembly codes in gcc are AT&T style. */
	__asm("in %%dx, %%al"
		: "=a" (result)		/* Output, result as ax */
		: "d" (port));		/* Input, port as dx */

	return result;
}

void port_byte_out(word port, byte data)
{
	__asm("out %%al, %%dx"
		:							/* No output */
		: "a" (data), "d" (port));	/* Input, data as ax and port as dx. */
}

word port_word_in(word port)
{
	word result;

	__asm("in %%dx, %%ax" : "=a" (result) : "d" (port));

	return result;
}

void port_word_out(word port, word data)
{
	__asm("out %%ax, %%dx" : : "a" (data), "d" (port));
}
