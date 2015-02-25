module LFSR_tb();
   reg clk; //inputs for the DUT
   wire LSFR_out; //outputs for the DUT

   //initialize DUT
   LFSR r(LFSR_out, clk);

   //setup variables
   initial begin
      clk = 0;
   end

   //run our test
   initial begin
      //initial text & monitor
      $display("ECEN 449 Spring 2015, Yinwei Zhang's submission for assignment 1, question 4.");
      $display("Test for LFSR, which is a random bit generator.");
      $display("\nInput/Output");
      
      $monitor("[clk == %b] ==> [LFSR_OUT == %b]", clk, LFSR_out);
      //end
      #15 $finish;
   end // initial begin

   //start clock
   always
     #5 clk = ~clk;

endmodule // LFSR_tb


   
