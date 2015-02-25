module mod4c_tb();
   reg clk, rst; //inputs for the DUT
   wire [1:0] count4; //outputs for the DUT

   //initialize DUT
   mod4c c(count4, clk, rst);

   //setup variables
   initial begin
      clk = 0;
      rst = 1;
   end

   //run our test
   initial begin
      #5 rst = 0; //turn reset off, so it starts counting

      //initial text & monitor
      $display("ECEN 449 Spring 2015, Yinwei Zhang's submission for assignment 1, question 2, part 1.");
      $display("Test for mod4c, which is a counter that counts to 4 and resets itself afterwards.\n Counters per clock cycle, also zeros on reset.");
      $display("\nInput/Output");

      $monitor("[clk == %b][rst == %b] ===> [count4 == %b]", clk, rst, count4);

      //check reset at timestep 10
      #25 rst = 1;
      #30 rst = 0;

      //finish at timestep 15
      #15 $finish;
   end // initial begin

   //start clock
   always
     #5 clk = ~clk;

   
endmodule // mod4c_tb

   
