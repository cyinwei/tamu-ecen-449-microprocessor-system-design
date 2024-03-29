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

   reg [2:0] 		   currentPWMCounter; //counts the discrete width of the input PWM
   reg [2:0] 		   oldPWMCounter; //counts the discrete width of the input PWM
   reg [1:0] 		   PCMCounter; //used to count the digit output of the output PCM

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
