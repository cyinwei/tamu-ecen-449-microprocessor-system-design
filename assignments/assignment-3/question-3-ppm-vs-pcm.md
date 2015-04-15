#Question 3

PCM needs more synchronization than PPM.  For PCM, we sample our analog signal into chunks, into log_2(size) bits per period.  To do this, we need to pass the clock to the reciever, and to train the reciever initially with training pulses.  For PPM, we can figure out the period by the agreed initial pulse value and the time difference between the first and second pulse (and second and third pulse, and so on).

So PPM needs less synchronization, but it has to pass more bits.  Over each period, it passes only 1 pulse, which translates into 1 value (comparable to 1 bit).  For PCM, we pass log_2() bits per period because of sampling.  Therefore, PCM transmits data much faster than PPM.
