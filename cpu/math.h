/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2021/2/26 Created by MYM.
 *
 *-------------------------------------------------------------*/

#ifndef MATH_H
#define MATH_H

/* Defined in math.asm */
extern void init_fpu();
extern void set_ts();
extern void save_fpu_context(void*);
extern void restore_fpu_context(void*);

/* Some function-like macros */
#define clear_ts() __asm("clts")
#define reinit_fpu() __asm("fninit")

#endif

