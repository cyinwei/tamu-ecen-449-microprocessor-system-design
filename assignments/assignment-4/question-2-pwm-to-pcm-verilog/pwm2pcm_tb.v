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
