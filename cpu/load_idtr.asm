[bits 32]
[extern _idtr]

global _load_idtr

; Prototype: void load_idtr();
_load_idtr:
	lidt [_idtr]
	ret
	