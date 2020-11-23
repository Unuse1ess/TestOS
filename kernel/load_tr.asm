[bits 32]

global _load_tr

; Prototype: void load_tr(word tss_sel);
_load_tr:
	push ebp
	mov ebp, esp

	ltr [ebp + 8]

	leave
	ret