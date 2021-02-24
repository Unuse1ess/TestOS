/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/13 Created by MYM.
 *
 *-------------------------------------------------------------*/

#ifndef SEMA_H
#define SEMA_H

#ifndef TASK_H
#error "kernel/task.h" is not included
#endif

#ifndef SPIN_LOCK_H
#error "kernel/spin_lock.h" is not included
#endif

typedef struct _tagSEMAPHORE
{
	SPIN_LOCK lock;
	TCB* wait_queue;
	int value;

	/* Number of threads that are using this seamphore.
	 * When it is 0, it is released automatically.
	 */
	int ref;
}SEMAPHORE;


#endif // !SEMA_H
