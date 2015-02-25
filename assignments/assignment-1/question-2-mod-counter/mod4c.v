/* mod4c.v
 * A counter that counts (mod 4).  It counts from 0 to 4, then resets back to 0 again.
 * 
 * In structural verilog.
 * 
 * @author: Yinwei Zhang
 * @for: TAMU ECEN 449 Spring 2015, Dr. Sunil P Khatri
 * @date: 25.02.2015
 */

module mod4c(count4, clk, rst);
   input clk, rst;
   output [1:0] count4;

   wire   notRst;
   wire   Q1, Q2; //the output from each D flip flop
   wire   nothing1, nothing2; //used to pass to D flip flop for Qnot

   wire   longClock;
   wire   notLongClock;

   //assign Q1 = 1;
   
   xor(longClock, clk, Q1);
   
   d_flip_flop_nand d1(Q1, nothing1, clk, longClock);
   d_flip_flop_nand d2(Q2, nothing2, clk, Q1);

   not(notRst, rst);
   and(count4[0], Q1, notRst);
   and(count4[1], Q2, notRst);
   
endmodule
   
