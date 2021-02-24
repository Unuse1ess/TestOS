/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2021/2/22 Created by MYM.
 *
 *-------------------------------------------------------------*/

#ifndef  SPIN_LOCK_H
#define SPIN_LOCK_H


#ifndef TYPES_H
#error "/kernel/types.h" is not included
#endif


/* In MP system, it should be padding to be
 * aligned with size of cache line to prevent
 * perfomance problem of cache coherency.
 */
typedef struct
{
	int locked;
}SPIN_LOCK;

/* Implemented in spin_lock.asm */
extern void spin_lock(SPIN_LOCK* lock);
extern int spin_unlock(SPIN_LOCK* lock);

#endif // ! LOCK_H
