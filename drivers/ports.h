#ifndef PORTS_H
#define PORTS_H

#ifndef TYPES_H
#error "kernel/types.h" is not included
#endif


/* Implemented in ports.asm */
byte port_byte_in(word port);
void port_byte_out(word port, byte data);
word port_word_in(word port);
void port_word_out(word port, word data);
dword port_dword_in(word port);
void port_dword_out(word port, dword data);

/* size must be a multiple of 4 */
void* port_buffer_in(word port, void* buffer, unsigned size);
void port_buffer_out(word port, void* buffer, unsigned size);

#endif