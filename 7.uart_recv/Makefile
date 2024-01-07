TOP=..

-include  $(TOP)/Make.local
include $(TOP)/Make.rules

.PHONY: all clean burn world timings

FILES= \
	top.v \
	Debounce_Switch.v \
	Seven_Segment.v \
	UART_RX.v

all:: top.bin


#top.blif: $(FILES)
#	$(COMPILE.v) -p "synth_ice40 -top top -blif $@" $^

top.json: $(FILES)
	$(COMPILE.v) -p "synth_ice40 -top top -json $@" $^

timing: top.asc
	icetime -tmd $(DEVICE) $^

top_tb.vvp: top_tb.v top.v

plot: top_tb.vcd
	gtkwave $^

prog: top.bin
	$(FLASH_PROG) $^


# extra dependancies
top.asc: $(PINMAP)

# uart testing
uart_rx_tb:: uart_rx_tb.vcd

uart_rx_tb.vvp: uart_rx_tb.v UART_RX.v
	iverilog -o $@ $^
