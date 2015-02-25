module d_flip_flop_nand_tb();
   reg clk, d; //inputs for the DUT
   wire Q, Qn; //outputs for the DUT

   //initialize DUT
   d_flip_flop_nand dF(Q, Qn, clk, d);

   //setup variables
   initial begin
      clk = 0;
      d = 1;
   end

   //run our test
   initial begin
      //initial text & monitor
      $display("ECEN 449 Spring 2015, Implementation for a D flip flop.");
      $display("\nInput/Output");

      $monitor("[clk == %b][D == %b] ===> [Q == %b][Qn == %b]", clk, d, Q, Qn);

      #10 d = 0;
      #10 d = 1;

      //finish at timestep 20
      $finish;
   end // initial begin

   //start clock
   always
     #5 clk = ~clk;

   
endmodule // mod4c_tb

   
