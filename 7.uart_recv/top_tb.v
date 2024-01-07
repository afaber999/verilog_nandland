`timescale 1ns/10ps

module tb();

  // Testbench uses a 25 MHz clock (same as Go Board)
  // Want to interface to 115200 baud UART
  // 25000000 / 115200 = 217 Clocks Per Bit.
  parameter c_CLOCK_PERIOD_NS = 40;
  parameter c_CLKS_PER_BIT    = 217;
  parameter c_BIT_PERIOD      = 8600;

  reg r_Clock = 0;
  reg r_RX_Serial = 1;
  wire [7:0] w_RX_Byte;

  UART_RX #(.CLKS_PER_BIT(217)) uut (
    .i_Clock(r_Clock),
    .i_RX_Serial(r_RX_Serial),
    .o_RX_DV(),
    .o_RX_Byte(w_RX_Byte)
  ) ;

   always
      #(c_CLOCK_PERIOD_NS/2) r_Clock <= !r_Clock;


  // Takes in input byte and serializes it 
  task UART_WRITE_BYTE;
    input [7:0] i_Data;
    integer ii;
    begin
      // Send Start Bit
      r_RX_Serial <= 1'b0;
      #(c_BIT_PERIOD);
      #1000;

      // Send Data Byte
      for (ii=0; ii<8; ii=ii+1) begin
        r_RX_Serial <= i_Data[ii];
        #(c_BIT_PERIOD);
      end

      // Send Stop Bit
      r_RX_Serial <= 1'b1;
      #(c_BIT_PERIOD);
    end
  endtask // UART_WRITE_BYTE

  initial begin
    $dumpfile("top_tb.vcd");        // where to write the dump
    $dumpvars;                      // dump EVERYTHING
  end

  // Main Testing:
  initial begin
      // Send a command to the UART (exercise Rx)
      @(posedge r_Clock);
      UART_WRITE_BYTE(8'h37);
      @(posedge r_Clock);
            
      // Check that the correct command was received
      if (w_RX_Byte == 8'h37)
        $display("Test Passed - Correct Byte Received");
      else
        $display("Test Failed - Incorrect Byte Received");
    $finish();
    end

endmodule
