DEPENDENCIES = LFSR.v LFSR_tb.v d_flip_flop_nand.v

all: lfsr

lfsr: $(DEPENDENCIES)
	iverilog -o $@ $^

clean:
	rm lfsr 
