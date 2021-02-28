;-------------------------------------------------------
;						History
;	Version 0.1:
;		2021/2/22 Created by MYM.
;-------------------------------------------------------
[bits 32]

global _spin_lock_
global _spin_unlock_


; Spin lock implemented in assembly for stability and efficiency.
; Note that it is only used in kernel and for critical section
; codes that modifying semaphores. And, these codes can be used in
; multi-processor system.
; Also note that since kernel space is shared with all the user
; programs, which is shared data, codes that modifies them must be
; in critical section.

; Prototype: void spin_lock(SPIN_LOCK* lock);
_spin_lock:
	mov eax, 1

locked:
	cmp dword [esp + 4], 0
	jz get_lock

; To tell the processor that it is a spin lock to improve its performance.
; It is according to Intel's suggestion.
	pause
	jmp locked

get_lock:
	xchg eax, [esp + 4]
	test eax, eax			; See if there is someone else changing the lock in advance
	jnz locked				; ZF == 1 indicates that someone has changed
							; and is using the lock, so spin again.
	
	ret

; Prototype: int spin_unlock(SPIN_LOCK* lock);
_spin_unlock:
	xor eax, eax
	xchg eax, [esp + 4]
	dec eax				; Trying to unlock an unlocked spin lock will return -1,
	ret					; and if everything is right, it returns 0.
