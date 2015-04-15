#Question 1
In the context of drivers,

##Major and minor number
Major number numbers allows the device to be categorized with other devices.  For example, all mouses should share a major number, allowing other programs that use a mouse to just use the major number to search rather than search throughout all of `/dev`.  Minor numbers separate devices of the same type, allowing processes to distinguish between hardware that do the same thing.

##Semaphore
Semaphores allow different processes to use the same memory, or in this case the device (through its driver), at "once" by giving a set of rules for the processes to follow.  A sempahore is a traffic light in Spanish, and it allows a certain (user-defined) number of processes to access the same device, while the other processes have to wait until those processes are finished to use the device.

It's necessary, because if multiple processes write to the same device (at the same exact register), we'll get a problem, as we don't know which process succeeded, or even a corruption problem if the register if more than 1 bit wide.  Semaphores prevent race conditions and allow multiple processes to use the device by blocking and unblocking the participating processes.

##Wait Queue
A Semaphore is implemented with a wait queue.  The wait queue determines which process goes next after the current processes is done.  In Linux, a wait queue is a struct that has pointers to the tast and a linked list type pointer to the next process.
