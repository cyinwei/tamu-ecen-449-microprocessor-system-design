/* mod8c.v
 * A counter that counts (mod 8).  It counts from 0 to 7, then resets back to 0 again.
 * 
 * In behavioral verilog.
 * 
 * @author: Yinwei Zhang
 * @for: TAMU ECEN 449 Spring 2015, Dr. Sunil P Khatri
 * @date: 18.02.2015
 */

module mod8c(count8, clk, rst);
   input clk;
   input rst;
   output reg [2:0] count8; //counting from 0..7 needs 3 bits, 2^3 = 8

   //counter input behavior, it counts upwards
   always@ (posedge clk) begin
      //check rst to see if we should set to 0
      if (rst == 1)
	count8 <= 3'b000;
      else if (rst == 0) begin
	 count8 <= count8 + 1; //we can use nonblocking here, since we only increment once

	 if (count8 == 3'b111) begin //count8 == 7, let's reset
	    count8 <= 3'b000; //this nonblocking assignment overrides the previous behavior
	 end
      end
   end
   
endmodule
 
 
