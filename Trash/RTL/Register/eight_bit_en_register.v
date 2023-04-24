module eight_bit_en_register(in, clk, en, rst, out);

	input [7:0] in;
	input clk; //clock
	input rst; //reset
    input en; //enable
	
	output [7:0] out;
    wire[7:0] reg_out, mux_out;
	
eight_bit_register_behavioral_module eight_bit_register(.in(mux_out), .clk(clk), .rst(rst), .out(reg_out));
eight_bit_two_to_one_mux_gatelevel_module  eight_bit_mux(.a(reg_out), .b(in), .s(en), .out(mux_out));

assign out = reg_out;

endmodule
