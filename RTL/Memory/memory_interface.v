module memory_interface(
    input [7:0] data_i,
    //input we_0,
    //input we_1,
    input sel,
    input [5:0] addr_0,
    input [5:0] addr_1,
    input [7:0] q_i,

    output [5:0] addr_o,
    output we_o,
    output [7:0] data_o,
    output [7:0] q_o
);
    six_bit_two_to_one_mux_gatelevel_module six_bit_two_to_one_mux(
        .a(addr_0),
        .b(addr_1),
        .s(sel),
        .out(addr_o)
    );

    two_to_one_mux_gatelevel_module two_to_one_mux(
	    .a(1'b1), 
        .b(1'b0),
	    .s(sel),	
	    .out(we_o)
    );

    assign data_o = data_i;
    assign q_o = q_i;
endmodule