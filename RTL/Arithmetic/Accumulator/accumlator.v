module eight_bit_accumulator(in, clk, en, rst, out);

	input [7:0] in;
    input en, clk, rst;
	output [7:0] out;
 
    
     wire[7:0] sum_out;
    wire[7:0] load_out, mux_out;

eight_bit_full_adder_module eight_bit_adder(.a(in), .b(out), .cin(1'b0), .sum(sum_out), .cout());
eight_bit_two_to_one_mux_gatelevel_module eight_bit_mux(.a(load_out), .b(sum_out), .s(en), .out(mux_out));
eight_bit_register_behavioral_module eight_bit_register(.in(mux_out), .clk(clk), .rst(rst), .out(load_out));
 
 assign out = load_out;

endmodule

