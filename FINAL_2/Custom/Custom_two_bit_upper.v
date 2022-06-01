// active like two_bit_enalbe_counter
module two_bit_upper(
    input           clk, 
    input           en, 
    input           rst, 
    output [1:0]    out
);

    wire [1:0] q_add_1;
    wire [1:0] q;
    wire [1:0] mux_out;
    
    two_bit_full_adder_module two_bit_full_adder_module(.a(q), .b(2'b01), .cin(1'b0), .sum(q_add_1), .cout());
    two_bit_two_to_one_mux two_bit_two_to_one_mux_inst(.a(q), .b(q_add_1), .s(en), .out(mux_out));
    two_bit_register_module two_bit_register_module(.in(mux_out), .clk(clk), .rst(rst), .out(q));

    assign out = q;

endmodule
