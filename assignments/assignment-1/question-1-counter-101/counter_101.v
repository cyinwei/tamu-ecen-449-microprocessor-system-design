/* counter_101.v
 * @author: Yinwei Zhang
 * @for: CSCE 449 Assignment 1
 * @date: 18.02.2015
 */

//note our specifications don't mention a clock signal...

module counter_101(count, datain);
    input [6:0] datain;
    output reg [1:0] count; //count has a max value of 3
    //with input 7'b1010101
    
    always@ (datain) begin
        count = 0;
        if (datain[6:4] == 3'b101) begin
            count = count + 1;
        end
        if (datain[5:3] == 3'b101) begin
            count = count + 1;
        end
        if (datain[4:2] == 3'b101) begin
            count = count + 1;
        end
        if (datain[3:1] == 3'b101) begin
            count = count + 1;
        end
        if (datain[2:0] == 3'b101) begin
            count = count + 1;
        end
    end

endmodule
