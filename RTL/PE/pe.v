module PE(a_in, b_in, y_in, en_reg_A, en_reg_B, en_reg_Add, en_reg_Acc, clk, rst, y_out, a_out, b_out, s_mode_out);


	input [7:0] a_in, b_in, y_in, b_out; // b_out is used only for simaulation systolic array
    input en_reg_A, en_reg_B, en_reg_Add, en_reg_Acc, clk, rst;
	output [7:0] y_out, a_out, s_mode_out;

    wire[7:0] mul_out1, mul_out2;
    wire[7:0] load_a, load_b, add_result;

//Serial mode
eight_bit_multipiler_module  eight_bit_multiplier1(.a(a_in), .b(b_in), .out(mul_out1));
eight_bit_accumulator eight_bit_accumulator(.in(mul_out1), .clk(clk), .en(en_reg_Acc), .rst(rst), .out(s_mode_out));

//Parallel mode
eight_bit_en_register register_A(.in(a_in), .clk(clk), .en(en_reg_A), .rst(rst), .out(load_a));
eight_bit_en_register register_B(.in(b_in), .clk(clk), .en(en_reg_B), .rst(rst), .out(load_b));
eight_bit_multipiler_module eight_bit_multiplier2(.a(a_in), .b(load_b), .out(mul_out2));
eight_bit_full_adder_module eight_bit_adder(.a(mul_out2), .b(y_in), .cin(1'b0), .sum(add_result), .cout());
eight_bit_en_register register_Add(.in(add_result), .clk(clk), .en(en_reg_Add), .rst(rst), .out(y_out));

assign a_out = load_a;
assign b_out = b_in;

endmodule
