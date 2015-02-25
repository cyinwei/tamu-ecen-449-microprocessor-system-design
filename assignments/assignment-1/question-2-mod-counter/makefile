all: mod8c mod4c

mod8c: mod8c.v mod8c_tb.v
	iverilog -o $@ $^

mod4c: mod4c.v mod4c_tb.v d_flip_flop_nand.v
	iverilog -o $@ $^

d_flip_flop_nand: d_flip_flop_nand.v d_flip_flop_nand_tb.v
	iverilog -o $@ $^

clean:
	rm mod8c mod4c 
