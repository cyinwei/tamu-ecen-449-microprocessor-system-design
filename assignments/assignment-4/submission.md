#TAMU ECEN449 Assignment 4
@author: Yinwei (Charlie) Zhang
@date: 22 April 2015

##Question 1
###A. Initial SuperMegaX-3

Given a time multiplexed pulse modulation scheme with period 1 microsecond, we have 4 different modulation schemes.  We have a PPM with 2 bits of width, a PWM with 3 bits of width, a PAM with 4 bits of width, and a PCM of 5 bits of width.

So in 1 sample period, we effectively have 2+3+4+5, or 14 bits.  Standarized to bits/sec that would be 

$$\frac{14 bits}{\mu seconds} * \frac{10^{6} \mu seconds}{second} = \frac{14Mbits}{second}$$

###B. Revised SuperMegaX-3

With the revised pulse modulation, we change the period of the PPM to 0.125 microseconds, and lengthen the period of the PWM to 0.375 microseconds.  However, that doesn't change the effective bit rate, since the different values passed are still the same; it just changes the windows which the signals are multiplexed.

So the effective bit rate is still 14Mbits per second. 

##Question 2
**NOTE**: My implementation, compiles, but **DOES NOT** give the correct output... I don't know why (my Verilog isn't good enough).

###Verilog implementation 
```verilog
/* pwm2pcm.v
 * Converts input signal SuperMegaX4, a PWM signal, into HyperMegaPCM, a pcm signal.
 * Both PWM and PCM have period 24ns.
 * PWM:
 *   8 discrete different values
 * PCM:
 *   3 different clk signals
 *     clk = 24ns
 *     clk3 = 8ns
 *     clk8 = 3ns  
 
 * Note: There is no way to give the PCM output in the same period as the PWM.
 *   So the output is delayed by 1 cycle. 
 */

module pwm2pcm (input SuperMegaX4,
    input clk,
    input clk8,
    input clk3,
    output reg HyperMegaPCM
    );

   reg [2:0]       currentPWMCounter; //counts the discrete width of the input PWM
   reg [2:0]       oldPWMCounter; //counts the discrete width of the input PWM
   reg [1:0]       PCMCounter; //used to count the digit output of the output PCM

   //initial begin
     // currentPWMCounter <= 0;
     // oldPWMCounter <= 0;
   //end
   
   //initial values, set up 
   always @ (posedge clk) begin
      oldPWMCounter <= currentPWMCounter;
      currentPWMCounter <= 0;
      PCMCounter <= 0;
   end   
 
   //counts the input
   always @ (posedge clk8) begin
      //Assumes SuperMegaX4 has discrete inputs timed with clk3, clk 
      if (SuperMegaX4 == 1) begin
   currentPWMCounter <= currentPWMCounter + 1;
      end
      if (SuperMegaX4 == 0) begin
   currentPWMCounter <= 0;
   //note if SuperMegaX4 is 1 all the way throughout the period, 
   //  counter will natually zero out (its 3 bits wide for 8 values)
      end
   end // always @ (posedge clk3)
   
   
   //writes the output
   always @ (posedge clk3) begin
      if (PCMCounter == 0) begin
   HyperMegaPCM <= oldPWMCounter[0];
   PCMCounter <= PCMCounter + 1;
      end
      if (PCMCounter == 1) begin
   HyperMegaPCM <= oldPWMCounter[1];
   PCMCounter <= PCMCounter + 1;
      end
      if (PCMCounter == 2) begin
   HyperMegaPCM <= oldPWMCounter[2];
   PCMCounter <= 0;
      end
   end // always @ (posedge clk8)

   //really ghetto/hacky way of making the PCM block 1 ns wide
   always @ (HyperMegaPCM) begin
     if (HyperMegaPCM == 1)
       #1 HyperMegaPCM <= 0;
   end
   
endmodule   

```

###Testbench

```Verilog
`timescale 1ns/1ps

module pwmtopcmtest;

   //Inputs
   reg SuperMegaX4;
   reg clk;
   reg clk8;
   reg clk3;

   //Outputs
   wire HyperMegaPCM;

   //Instantiate the UUT
   pwm2pcm uut(.SuperMegaX4(SuperMegaX4),
         .clk(clk),
         .clk8(clk8),
         .clk3(clk3),
         .HyperMegaPCM(HyperMegaPCM)
         );

   initial begin //Initialize inputs
      SuperMegaX4 = 0;
   end

   //Clocks
   initial begin
      clk = 0;
      forever #12 clk = ~clk;
   end

   initial begin
      clk3 = 0;
      forever #4 clk3 = ~clk3;
   end

   initial begin
      clk8 = 1;
      forever #1.5 clk8 = ~clk8;
   end

   //Test
   initial begin
      $monitor("[%g | clk = %b, clk8 = %b, clk3 = %b] PCM output = %d", $time, clk, clk3, clk8, HyperMegaPCM);

      #12 SuperMegaX4 = 1;
      #6  SuperMegaX4 = 0;
      #18 SuperMegaX4 = 1;
      #12 SuperMegaX4 = 0;
      #12 SuperMegaX4 = 1;
      #18 SuperMegaX4 = 0;
      #30 $finish;
   end // initial begin

endmodule

```

###Print Output
```
./test
[0 | clk = 0, clk8 = 0, clk3 = 1] PCM output = x
[2 | clk = 0, clk8 = 0, clk3 = 0] PCM output = x
[3 | clk = 0, clk8 = 0, clk3 = 1] PCM output = x
[4 | clk = 0, clk8 = 1, clk3 = 1] PCM output = x
[5 | clk = 0, clk8 = 1, clk3 = 0] PCM output = x
[6 | clk = 0, clk8 = 1, clk3 = 1] PCM output = x
[8 | clk = 0, clk8 = 1, clk3 = 0] PCM output = x
[8 | clk = 0, clk8 = 0, clk3 = 0] PCM output = x
[9 | clk = 0, clk8 = 0, clk3 = 1] PCM output = x
[11 | clk = 0, clk8 = 0, clk3 = 0] PCM output = x
[12 | clk = 1, clk8 = 1, clk3 = 1] PCM output = x
[14 | clk = 1, clk8 = 1, clk3 = 0] PCM output = x
[15 | clk = 1, clk8 = 1, clk3 = 1] PCM output = x
[16 | clk = 1, clk8 = 0, clk3 = 1] PCM output = 0
[17 | clk = 1, clk8 = 0, clk3 = 0] PCM output = 0
[18 | clk = 1, clk8 = 0, clk3 = 1] PCM output = 0
[20 | clk = 1, clk8 = 0, clk3 = 0] PCM output = 0
[20 | clk = 1, clk8 = 1, clk3 = 0] PCM output = 0
[21 | clk = 1, clk8 = 1, clk3 = 1] PCM output = 0
[23 | clk = 1, clk8 = 1, clk3 = 0] PCM output = 0
[24 | clk = 0, clk8 = 0, clk3 = 1] PCM output = 0
[26 | clk = 0, clk8 = 0, clk3 = 0] PCM output = 0
[27 | clk = 0, clk8 = 0, clk3 = 1] PCM output = 0
[28 | clk = 0, clk8 = 1, clk3 = 1] PCM output = 0
[29 | clk = 0, clk8 = 1, clk3 = 0] PCM output = 0
[30 | clk = 0, clk8 = 1, clk3 = 1] PCM output = 0
[32 | clk = 0, clk8 = 1, clk3 = 0] PCM output = 0
[32 | clk = 0, clk8 = 0, clk3 = 0] PCM output = 0
[33 | clk = 0, clk8 = 0, clk3 = 1] PCM output = 0
[35 | clk = 0, clk8 = 0, clk3 = 0] PCM output = 0
[36 | clk = 1, clk8 = 1, clk3 = 1] PCM output = 0
[38 | clk = 1, clk8 = 1, clk3 = 0] PCM output = 0
[39 | clk = 1, clk8 = 1, clk3 = 1] PCM output = 0
[40 | clk = 1, clk8 = 0, clk3 = 1] PCM output = 0
[41 | clk = 1, clk8 = 0, clk3 = 0] PCM output = 0
[42 | clk = 1, clk8 = 0, clk3 = 1] PCM output = 0
[44 | clk = 1, clk8 = 0, clk3 = 0] PCM output = 0
[44 | clk = 1, clk8 = 1, clk3 = 0] PCM output = 0
[45 | clk = 1, clk8 = 1, clk3 = 1] PCM output = 0
[47 | clk = 1, clk8 = 1, clk3 = 0] PCM output = 0
[48 | clk = 0, clk8 = 0, clk3 = 1] PCM output = 0
[50 | clk = 0, clk8 = 0, clk3 = 0] PCM output = 0
[51 | clk = 0, clk8 = 0, clk3 = 1] PCM output = 0
[52 | clk = 0, clk8 = 1, clk3 = 1] PCM output = 0
[53 | clk = 0, clk8 = 1, clk3 = 0] PCM output = 0
[54 | clk = 0, clk8 = 1, clk3 = 1] PCM output = 0
[56 | clk = 0, clk8 = 1, clk3 = 0] PCM output = 0
[56 | clk = 0, clk8 = 0, clk3 = 0] PCM output = 0
[57 | clk = 0, clk8 = 0, clk3 = 1] PCM output = 0
[59 | clk = 0, clk8 = 0, clk3 = 0] PCM output = 0
[60 | clk = 1, clk8 = 1, clk3 = 1] PCM output = 0
[62 | clk = 1, clk8 = 1, clk3 = 0] PCM output = 0
[63 | clk = 1, clk8 = 1, clk3 = 1] PCM output = 0
[64 | clk = 1, clk8 = 0, clk3 = 1] PCM output = 0
[65 | clk = 1, clk8 = 0, clk3 = 0] PCM output = 0
[66 | clk = 1, clk8 = 0, clk3 = 1] PCM output = 0
[68 | clk = 1, clk8 = 0, clk3 = 0] PCM output = 0
[68 | clk = 1, clk8 = 1, clk3 = 0] PCM output = 0
[69 | clk = 1, clk8 = 1, clk3 = 1] PCM output = 0
[71 | clk = 1, clk8 = 1, clk3 = 0] PCM output = 0
[72 | clk = 0, clk8 = 0, clk3 = 1] PCM output = 0
[74 | clk = 0, clk8 = 0, clk3 = 0] PCM output = 0
[75 | clk = 0, clk8 = 0, clk3 = 1] PCM output = 0
[76 | clk = 0, clk8 = 1, clk3 = 1] PCM output = 0
[77 | clk = 0, clk8 = 1, clk3 = 0] PCM output = 0
[78 | clk = 0, clk8 = 1, clk3 = 1] PCM output = 0
[80 | clk = 0, clk8 = 1, clk3 = 0] PCM output = 0
[80 | clk = 0, clk8 = 0, clk3 = 0] PCM output = 0
[81 | clk = 0, clk8 = 0, clk3 = 1] PCM output = 0
[83 | clk = 0, clk8 = 0, clk3 = 0] PCM output = 0
[84 | clk = 1, clk8 = 1, clk3 = 1] PCM output = 0
[86 | clk = 1, clk8 = 1, clk3 = 0] PCM output = 0
[87 | clk = 1, clk8 = 1, clk3 = 1] PCM output = 0
[88 | clk = 1, clk8 = 0, clk3 = 1] PCM output = 0
[89 | clk = 1, clk8 = 0, clk3 = 0] PCM output = 0
[90 | clk = 1, clk8 = 0, clk3 = 1] PCM output = 0
[92 | clk = 1, clk8 = 0, clk3 = 0] PCM output = 0
[92 | clk = 1, clk8 = 1, clk3 = 0] PCM output = 0
[93 | clk = 1, clk8 = 1, clk3 = 1] PCM output = 0
[95 | clk = 1, clk8 = 1, clk3 = 0] PCM output = 0
[96 | clk = 0, clk8 = 0, clk3 = 1] PCM output = 0
[98 | clk = 0, clk8 = 0, clk3 = 0] PCM output = 0
[99 | clk = 0, clk8 = 0, clk3 = 1] PCM output = 0
[100 | clk = 0, clk8 = 1, clk3 = 1] PCM output = 0
[101 | clk = 0, clk8 = 1, clk3 = 0] PCM output = 0
[102 | clk = 0, clk8 = 1, clk3 = 1] PCM output = 0
[104 | clk = 0, clk8 = 1, clk3 = 0] PCM output = 0
[104 | clk = 0, clk8 = 0, clk3 = 0] PCM output = 0
[105 | clk = 0, clk8 = 0, clk3 = 1] PCM output = 0
[107 | clk = 0, clk8 = 0, clk3 = 0] PCM output = 0
[108 | clk = 1, clk8 = 1, clk3 = 1] PCM output = 0

```

##Question 3
(a) `chmod 740 fpga`
(b) `wget http://www.fpga.com/bitstream.gz`
(c) `tar -zxvf bitstream.gz`
(d) `lsof -u jack -u dave`
(e) `grep -r "fpga" -l`

##Question 4

###(a) Polling vs Interrupts
With polling, the processor checks every *X* amount of time to see if a connected device has a request.  With interrupts, the device sends a signal over to the processor (or the interrupt controller), which will alert the processor then.

It's comparable synchronous checks, polling, vs asynchronous checks, interrupts.

With polling, there's CPU usage even if there are no requests.  With interrupts, we know that CPU time is *fully* used for requests.  However, the tradeoff is the response time.  With polling, we can have faster, more guaranteed responses, since the processor explicitly clears from other processes to check the requests.  With interrupts, the processor usually waits until the current process is finished or timed out (scheduling) before handling the interrupt, resulting in a slower response time.

###(b) Uniprocessor at a thermal plant
With a uniprocessor, which is *designed* to respond to unexpected temperature and pressure, we want to use **polling**.  Especially if we want to guarantee that the response time is within 1ms.  

That's because with interrupts, if the uniprocessor is currently running a process, it will have to wait until that process is over, times out, or cleans itself, which takes valuable time.  With polling, the processor is idle, and can guarantee it can catch the sensor error within 1ms if the polling frequency is within 1ms.