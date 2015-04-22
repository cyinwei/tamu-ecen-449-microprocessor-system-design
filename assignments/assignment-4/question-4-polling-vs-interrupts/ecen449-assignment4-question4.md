##Question 4

###(a) Polling vs Interrupts
With polling, the processor checks every *X* amount of time to see if a connected device has a request.  With interrupts, the device sends a signal over to the processor (or the interrupt controller), which will alert the processor then.

It's comparable synchronous checks, polling, vs asynchronous checks, interrupts.

With polling, there's CPU usage even if there are no requests.  With interrupts, we know that CPU time is *fully* used for requests.  However, the tradeoff is the response time.  With polling, we can have faster, more guaranteed responses, since the processor explicitly clears from other processes to check the requests.  With interrupts, the processor usually waits until the current process is finished or timed out (scheduling) before handling the interrupt, resulting in a slower response time.

###(b) Uniprocessor at a thermal plant
With a uniprocessor, which is *designed* to respond to unexpected temperature and pressure, we want to use **polling**.  Especially if we want to guarantee that the response time is within 1ms.  

That's because with interrupts, if the uniprocessor is currently running a process, it will have to wait until that process is over, times out, or cleans itself, which takes valuable time.  With polling, the processor is idle, and can guarantee it can catch the sensor error within 1ms if the polling frequency is within 1ms.