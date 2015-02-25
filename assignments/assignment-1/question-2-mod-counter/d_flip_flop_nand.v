/* D flup flop constructed from nand gates.
 * @design from http://asic-world.com/verilog/gate2.html 
 */

module d_flip_flop_nand(Q, Qn, clk, D);
   input clk, D;
   output Q, Qn;

   wire   X, Y; //X, Y are the output from the 1st 2 nands

   nand n1(X, D, clk);
   nand n2(Y, X, clk);
   nand n3(Q, Qn, X);
   nand n4(Qn, Q, Y);

endmodule //d_flip_flop_nand
   

