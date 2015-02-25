/* LFSR.v
 * @author: Yinwei Zhang
 * 
 * Mixed Verilog
 */

module LFSR(LFSR_out, clk);
   input clk;
   output LFSR_out;

   wire    Q1, Q2, Q3, Q4; //the outputs from each flip flop
   reg 	   D1, D2, D3, D4; //this are the inputs, which we set to 1... somehow???
   
   wire   Q1xorOut; //xor value that goes into the second flip flop

   wire [3:0] noCare; //don't care about these ; connect's to the Qn of each flip flop       
   
   d_flip_flop_nand d1(Q1, noCare[0], clk, LFSR_out);
   xor(Q1xorOut, Q1, LFSR_out);
   d_flip_flop_nand d2(Q2, noCare[1], clk, Q1xorOut);
   d_flip_flop_nand d3(Q3, noCare[2], clk, Q2);
   d_flip_flop_nand d4(LFSR_out, noCare[3], clk, Q3);

endmodule 
   
   
   
   
