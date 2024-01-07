
// implementing AND gate
module top
    (   input i_Switch_1, 
        input i_Switch_2,
        output o_LED_1 );

// AND switches with LED
assign o_LED_1 = i_Switch_1 & i_Switch_2;

endmodule