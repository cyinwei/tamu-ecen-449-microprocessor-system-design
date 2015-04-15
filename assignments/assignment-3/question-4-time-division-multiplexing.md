#Question 4

Don't really understand how to do this ...

##Given

- Bandwidth = 20Gbps
- Voice bandwidth = 4-10KHz
- Sample rate = double analog

- Use Time Division Multiplexing

- So sample rate is 20KHz

 

##PCM

5 bits/sample

With TDM, we divide the period of (10Khz)^-1 into smaller chunks.  Since our bandwidth is 20Gbps, and the ratio is 5:1, our effective bandwidth is 4GHz.  4Ghz / 20KHz is 200,000, so hypothetically, we can sustain ~200k phone calls, by dividing the periods into a 20Gbps frequency.

##PPM

32 bits/sample

The ratio is 32:1, so our effective bandwidth is 625MHz.  625MHz / 20kHz = 31250, so we can hypothetically sustain 31250 phone calls.