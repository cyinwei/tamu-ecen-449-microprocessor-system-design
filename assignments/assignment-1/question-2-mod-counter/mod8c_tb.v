module mod8c_tb();
   reg clk, rst; //inputs for our mod8c
   wire [2:0] count8; //output from the mod8c

   //initialize our test "object"
   mod8c c(count8, clk, rst);
   
   //test time
   initial begin
      //initialize values
      clk = 0;
      rst = 1; //to zero out our count8

      #4 rst = 0;

      $display("ECEN 449 Spring 2015, Yinwei Zhang's submission for assignment 1, question 2, part 2.");
      $display("Test for mod8c, which is a counter that counts to 8 and resets itself afterwards.\n Counters per clock cycle, also zeros on reset.");
      $display("\nInput/Output");

      $monitor("[clk == %b][rst == %b] ===> [count8 == %b]", clk, rst, count8);

      //test the reset button manually
      #2 rst = 1;
      #2 rst = 0;
      
      //run for 50 cycles
      #60 $finish;
   end // initial begin

   //start the clock
   always
     #1 clk = ~clk;

endmodule

      
