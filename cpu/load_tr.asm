;------------------------------------------------------------------
;							History
;	Version 0.1:
;		2021/1/22 Created by MYM.
;------------------------------------------------------------------

[bits 32]

global _load_tr

; Prototype: void load_tr(word tr);
_load_tr:
	ltr [esp + 4]
	ret