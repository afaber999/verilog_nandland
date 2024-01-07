module Seven_Segment (
  input i_Clk,
  input [3:0] i_Binary_Num,
  output o_Segment_A,
  output o_Segment_B,
  output o_Segment_C,
  output o_Segment_D,
  output o_Segment_E,
  output o_Segment_F,
  output o_Segment_G );

reg [6:0] r_seg = 7'h00;

always @(posedge i_Clk) begin

  case (i_Binary_Num) 
    'h0 : r_seg = 7'b0000001;
    'h1 : r_seg = 7'b1001111;
    'h2 : r_seg = 7'b0010010;
    'h3 : r_seg = 7'b0000110;
    'h4 : r_seg = 7'b1001100;
    'h5 : r_seg = 7'b0100100;
    'h6 : r_seg = 7'b0100000;
    'h7 : r_seg = 7'b0001111;
    'h8 : r_seg = 7'b0000000;
    'h9 : r_seg = 7'b0000100;
    'hA : r_seg = 7'b0001000;
    'hB : r_seg = 7'b1100000;
    'hC : r_seg = 7'b0110001;
    'hD : r_seg = 7'b1000010;
    'hE : r_seg = 7'b0110000;
    'hF : r_seg = 7'b0111000;
    default : r_seg = 7'b1111111; 
  endcase
end

assign o_Segment_A = r_seg[6];
assign o_Segment_B = r_seg[5];
assign o_Segment_C = r_seg[4];
assign o_Segment_D = r_seg[3];
assign o_Segment_E = r_seg[2];
assign o_Segment_F = r_seg[1];
assign o_Segment_G = r_seg[0];

endmodule
