@c
@c  COPYRIGHT (c) 1988-1998.
@c  On-Line Applications Research Corporation (OAR).
@c  All rights reserved.
@c
@c  $Id$
@c

@chapter Synchronization

@section Semaphore Characteristics

@example
sem_t, Type, Untested Implementation
@end example

@section Semaphore Functions

@subsection Initialize an Unnamed Semaphore

@example
sem_init(), Function, Untested Implementation
SEM_FAILED, Constant, Unimplemented
@end example

@subsection Destroy an Unnamed Semaphore

@example
sem_destroy(), Function, Untested Implementation
@end example

@subsection Initialize/Open a Named Semaphore

@example
sem_open(), Function, Untested Implementation
@end example

@subsection Close a Named Semaphore

@example
sem_close(), Function, Untested Implementation
@end example

@subsection Remove a Named Semaphore

@example
sem_unlink(), Function, Untested Implementation
@end example

@subsection Lock a Semaphore

@example
sem_wait(), Function, Untested Implementation
sem_trywait(), Function, Untested Implementation
@end example

@subsection Unlock a Semaphore

@example
sem_post(), Function, Untested Implementation
@end example

@subsection Get the Value of a Semaphore

@example
sem_getvalue(), Function, Untested Implementation
@end example

@section Mutexes

@subsection Mutex Initialization Attributes

@example
pthread_mutexattr_init(), Function, Implemented
pthread_mutexattr_destroy(), Function, Implemented
pthread_mutexattr_getpshared(), Function, Implemented
pthread_mutexattr_setpshared(), Function, Implemented
PTHREAD_PROCESS_SHARED, Constant, Implemented
PTHREAD_PROCESS_PRIVATE, Constant, Implemented
@end example

@subsection Initializing and Destroying a Mutex

@example
pthread_mutex_init(), Function, Implemented
pthread_mutex_destroy(), Function, Implemented
PTHREAD_MUTEX_INITIALIZER, Constant, Implemented
@end example

@subsection Locking and Unlocking a Mutex

@example
pthread_mutex_lock(), Function, Implemented
pthread_mutex_trylock(), Function, Implemented
pthread_mutex_unlock(), Function, Implemented
@end example

@section Condition Variables

@subsection Condition Variable Initialization Attributes

@example
pthread_condattr_init(), Function, Implemented
pthread_condattr_destroy(), Function, Implemented
pthread_condattr_getpshared(), Function, Implemented
pthread_condattr_setpshared(), Function, Implemented
@end example

@subsection Initialization and Destroying Condition Variables

@example
pthread_cond_init(), Function, Implemented
pthread_cond_destroy(), Function, Implemented
PTHREAD_COND_INITIALIZER, Constant, Implemented
@end example

@subsection Broadcasting and Signaling a Condition

@example
pthread_cond_signal(), Function, Implemented
pthread_cond_broadcast(), Function, Implemented
@end example

@subsection Waiting on a Condition

@example
pthread_cond_wait(), Function, Implemented
pthread_cond_timedwait(), Function, Implemented
@end example

