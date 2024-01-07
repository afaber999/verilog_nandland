`timescale 1ns/1ps

module tb();
  
  reg r_Clock = 1'b0;
  always #1 r_Clock <= ~r_Clock;

  // Need to set up parameters appropriately
  // These will blink much faster than on hardware.
  // This allows simulation to run quickly.
  top #(.g_COUNT_10HZ(5),
        .g_COUNT_5HZ(10), 
        .g_COUNT_2HZ(25),
        .g_COUNT_1HZ(50)) uut
    ( .i_Clk(r_Clock),
      .o_LED_1(),
      .o_LED_2(),
      .o_LED_3(),
      .o_LED_4());

  initial begin
    $dumpfile("top_tb.vcd");        // where to write the dump
    $dumpvars;                      // dump EVERYTHING
  end

  initial begin
    $display("Starting Testbench...");
    #200;
    $finish;
  end

endmodule
