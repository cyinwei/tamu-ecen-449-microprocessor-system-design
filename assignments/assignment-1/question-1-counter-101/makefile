all: counter-101-test

counter-101-test: counter_101.v counter_101_tb.v 
	iverilog -o counter-101-test *.v

clean:
	rm counter-101-test
