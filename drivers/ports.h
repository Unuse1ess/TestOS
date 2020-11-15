#ifndef PORTS_H
#define PORTS_H

#include "../kernel/types.h"

byte port_byte_in(word port);
void port_byte_out(word port, byte data);
word port_word_in(word port);
void port_word_out(word port, word data);

#endif