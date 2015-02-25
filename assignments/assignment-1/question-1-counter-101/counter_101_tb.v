module counter_101_tb();
    reg [6:0] datain;
    wire [1:0] count;
    
    //initialize our counter
    counter_101 c(count, datain);
    
    //now let's test the output
    initial begin
        #1 datain = 7'b0000000; //so we have an initial "initial" value
    
        $display("ECEN 449 Spring 2015, Yinwei Zhang's submission for assignment 1, question 1.");
        $display("Test for counter_101, which count's the number of 101s in a 7 bit input.");
        $display("\nInput/Output\ndatain ==> count");
        $monitor("Test:1[%b] ==> [%b]", datain, count);
        
        //there are 2^7 or 128 possible inputs, we're not going to test all of them
        //let's test the corner cases, with some random ones.
        
        //corner cases
        #1 datain = 7'b1111111;
        #1 datain = 7'b0000101;
        #1 datain = 7'b1010101;
        #1 datain = 7'b0101010;
        
        //random cases
        #1 datain = 7'b1101001;
        #1 datain = 7'b1111010;
        #1 datain = 7'b0110100;
        #1 datain = 7'b0011001;
        #1 datain = 7'b1010011;
        #1 datain = 7'b1010111;
        #1 datain = 7'b0101000;
        #1 datain = 7'b0001000;
    end
endmodule
