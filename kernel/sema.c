/*--------------------------------------------------------------
 *							History
 *	Version 0.1:
 *		2020/11/13 Created by MYM.
 *
 *-------------------------------------------------------------*/

#include "types.h"
#include "../cpu/seg.h"
#include "../cpu/page.h"
#include "memory.h"
#include "task.h"
#include "spin_lock.h"
#include "sema.h"
#include "../include/string.h"
#include "../include/stdlib.h"


// Semaphore that is used in user mode
//static SPIN_LOCK sema_alloc_lock = { 0 };
//static SEMAPHORE* sema_pool = NULL;
//
//int create_semaphore(int init_value)
//{
//	int i;
//	SEMAPHORE* sema = NULL;
//
//	/* Enter critical section */
//	spin_lock(&sema_alloc_lock);
//	if (!sema_pool)
//	{
//		sema_pool = alloc_page(PAGE_SYSTEM);
//		valloc_page((dword)sema_pool, (dword)sema_pool, PAGE_SYSTEM | PAGE_READ_WRITE);
//		memset(sema_pool, 0, SIZE_OF_PAGE);
//	}
//
//	for (i = 0; i < SIZE_OF_PAGE / sizeof(SEMAPHORE); i++)
//	{
//		if (!sema_pool[i].ref)
//		{
//			sema = &sema_pool[i];
//			break;
//		}
//	}
//
//	/* Run out of semaphores */
//	if (!sema)
//	{
//		i = -1;
//		goto _failed;
//	}
//
//	sema->wait_queue = NULL;
//	sema->lock.locked = 0;
//	sema->ref++;
//	sema->value = init_value;
//
//_failed:
//
//	/* Leave critical section */
//	spin_unlock(&sema_alloc_lock);
//
//	return i;
//}

//void up(SEMAPHORE* sema)
//{
//	spin_lock(&sema->lock);
//	sema->value++;
//	spin_unlock(&sema_pool[i].lock);
//
//	/* See if there is some threads waiting for it.
//	 * If the value is not positive, producer(s)
//	 * is waiting to be consumed.
//	 */
//	if (sema->value <= 0)
//	{
//		/* TODO: Wake up threads in wait queue */
//		
//	}
//}
//
//void down(SEMAPHORE* sema)
//{
//	spin_lock(&sema->lock);
//	sema->value--;
//	spin_unlock(sema->lock);
//
//	if (sema->value <= 0)
//	{
//		/* TODO: Suspend current thread by:
//		 *	1) Adding it to sema's wait queue.
//		 *	2) Switch to other available thread.
//		 */
//
//		 /* Once it resumes, it starts running from here.
//		  * That means consumer(s) has finished consumption,
//		  * and the protected shared resources are now available.
//		  */
//	}
//}
