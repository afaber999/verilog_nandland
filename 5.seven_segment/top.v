module top
  ( input i_Clk,
    input i_Switch_1,
    input i_Switch_2,
    output o_Segment2_A, 
    output o_Segment2_B, 
    output o_Segment2_C, 
    output o_Segment2_D, 
    output o_Segment2_E, 
    output o_Segment2_F,
    output o_Segment2_G );

  reg [3:0] r_Count = 3'b0000;
  reg r_Switch_1 = 1'b0;
  wire w_Switch_1;

  reg r_Switch_2 = 1'b0;
  wire w_Switch_2;

  // Instantiate debounce filer
  // 
  Debounce_Switch debounce_switch_1
    (
      .i_Clk( i_Clk ),
      .i_Switch(i_Switch_1),
      .o_Switch(w_Switch_1) 
    );

  Debounce_Switch debounce_switch_2
    (
      .i_Clk( i_Clk ),
      .i_Switch(i_Switch_2),
      .o_Switch(w_Switch_2) 
    );

  // Instantiate debounce filer
  // 
  Seven_Segment seven_segment_1
    (
      .i_Clk(i_Clk),
      .i_Binary_Num(r_Count),
      .o_Segment_A(o_Segment2_A),
      .o_Segment_B(o_Segment2_B),
      .o_Segment_C(o_Segment2_C),
      .o_Segment_D(o_Segment2_D),
      .o_Segment_E(o_Segment2_E),
      .o_Segment_F(o_Segment2_F),
      .o_Segment_G(o_Segment2_G) );

  // Purpose: Toggle LED .when() i_Switch_1 is released.
  always @(posedge i_Clk)
  begin

    r_Switch_1 <= w_Switch_1;
    r_Switch_2 <= w_Switch_2;
    
    if (w_Switch_1 == 1'b1 && r_Switch_1 == 1'b0)
    begin
      r_Count <= r_Count + 1;
    end else if (w_Switch_2 == 1'b1 && r_Switch_2 == 1'b0)
    begin
      r_Count <= r_Count + 15;
    end 
  end
 
endmodule