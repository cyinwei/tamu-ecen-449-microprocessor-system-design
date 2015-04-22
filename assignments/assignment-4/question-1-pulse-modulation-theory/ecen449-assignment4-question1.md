##Question 1
###A. Initial SuperMegaX-3

Given a time multiplexed pulse modulation scheme with period 1 microsecond, we have 4 different modulation schemes.  We have a PPM with 2 bits of width, a PWM with 3 bits of width, a PAM with 4 bits of width, and a PCM of 5 bits of width.

So in 1 sample period, we effectively have 2+3+4+5, or 14 bits.  Standarized to bits/sec that would be 

$$\frac{14 bits}{\mu seconds} * \frac{10^{6} \u seconds}{second} = \frac{14Mbits}{second}$$

###B. Revised SuperMegaX-3

With the revised pulse modulation, we change the period of the PPM to 0.125 microseconds.  