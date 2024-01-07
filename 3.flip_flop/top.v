
// implementing AND gate
module top
    (   input i_Clk, 
        input i_Switch_1,
        output o_LED_1 );


// define registers, only change them in always block
reg r_Switch_1 = 1'b0;
reg r_LED_1 = 1'b0;

always @(posedge i_Clk ) begin
    // non blocking assignment operator
    r_Switch_1 <= i_Switch_1; // creates a register, keeps track of 'previous' value

    // check if this is a falling edge
    if (i_Switch_1 == 1'b0 && r_Switch_1 == 1'b1) begin
        // toggle LED
        r_LED_1 <= ~r_LED_1;
    end
end

assign o_LED_1 = r_LED_1;

endmodule