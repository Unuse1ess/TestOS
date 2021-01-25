;-------------------------------------------------------
;						History
;	Version 0.1:
;		2021/1/24 Created by MYM.
;-------------------------------------------------------

[bits 32]

global _load_ldtr


; Prototype: void load_ldtr(word sel);
_load_ldtr:
	lldt [esp + 4]
	ret
