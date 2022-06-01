module systolic_array(
	clk, 
	rst, 
	en_reg_A, en_reg_B, en_reg_Acc, 
	B11, B12, B13, B21, B22, B23, B31, B32, B33, 
	sel_en_demux_result,
	input_demux_c_reg, 
	sel_en_demux_c_reg,
	row1_in, row2_in, row3_in,
	c11, c12, c21, c22
);

	input [7:0] row1_in, row2_in, row3_in, B11, B12, B13, B21, B22, B23, B31, B32, B33;
    input clk, rst, en_reg_A, en_reg_Acc, input_demux_c_reg;
	input [1:0] sel_en_demux_result, sel_en_demux_c_reg;
	input [8:0] en_reg_B;
	
	output [7:0] c11, c12, c21, c22;

	wire [7:0] wire_A [5:0];
	wire [7:0] wire_B [8:0];
	wire [7:0] adder_sum;
	wire [7:0] result;
	wire [7:0] demux_result_to_c11_reg, demux_result_to_c12_reg, demux_result_to_c21_reg, demux_result_to_c22_reg;
	wire en_c11_reg, en_c12_reg, en_c21_reg, en_c22_reg;


	// 3x3 PE structure
	PE pe1(.a_in(row1_in), .b_in(B11), .y_in(8'b0), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B[0]), .en_reg_Acc(en_reg_Acc),
		.clk(clk), .rst(rst), .y_out(wire_B[0]), .a_out(wire_A[0]), .s_mode_out());
	PE pe2(.a_in(wire_A[0]), .b_in(B12), .y_in(8'b0), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B[1]),  .en_reg_Acc(en_reg_Acc),
		.clk(clk), .rst(rst), .y_out(wire_B[1]), .a_out(wire_A[1]), .s_mode_out());
	PE pe3(.a_in(wire_A[1]), .b_in(B13), .y_in(8'b0), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B[2]),  .en_reg_Acc(en_reg_Acc),
		.clk(clk), .rst(rst), .y_out(wire_B[2]), .a_out(), .s_mode_out());
	PE pe4(.a_in(row2_in), .b_in(B21), .y_in(wire_B[0]), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B[3]),  .en_reg_Acc(en_reg_Acc),
		.clk(clk), .rst(rst), .y_out(wire_B[3]), .a_out(wire_A[2]), .s_mode_out());
	PE pe5(.a_in(wire_A[2]), .b_in(B22), .y_in(wire_B[1]), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B[4]),  .en_reg_Acc(en_reg_Acc),
		.clk(clk), .rst(rst), .y_out(wire_B[4]), .a_out(wire_A[3]), .s_mode_out());
	PE pe6(.a_in(wire_A[3]), .b_in(B23), .y_in(wire_B[2]), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B[5]),  .en_reg_Acc(en_reg_Acc),
		.clk(clk), .rst(rst), .y_out(wire_B[5]), .a_out(), .s_mode_out());
	PE pe7(.a_in(row3_in), .b_in(B31), .y_in(wire_B[3]), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B[6]),  .en_reg_Acc(en_reg_Acc),
		.clk(clk), .rst(rst), .y_out(wire_B[6]), .a_out(wire_A[4]), .s_mode_out());
	PE pe8(.a_in(wire_A[4]), .b_in(B32), .y_in(wire_B[4]), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B[7]),  .en_reg_Acc(en_reg_Acc),
		.clk(clk), .rst(rst), .y_out(wire_B[7]), .a_out(wire_A[5]), .s_mode_out());
	PE pe9(.a_in(wire_A[5]), .b_in(B33), .y_in(wire_B[5]), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B[8]),  .en_reg_Acc(en_reg_Acc),
		.clk(clk), .rst(rst), .y_out(wire_B[8]), .a_out(), .s_mode_out());	


	//adder
	eight_bit_full_adder_module eight_bit_adder1(.a(wire_B[6]), .b(wire_B[7]), .cin(1'b0), .sum(adder_sum), .cout());
	eight_bit_full_adder_module eight_bit_adder2(.a(adder_sum), .b(wire_B[8]), .cin(1'b0), .sum(result), .cout());


	// load result to c11, c12, c21, c22 register
	eight_bit_one_to_four_demux_gatelevel_module eight_bit_one_to_four_demux_result(
		.a      (result), 
		.s      (sel_en_demux_result), 
		.out1   (demux_result_to_c11_reg), 
		.out2   (demux_result_to_c12_reg), 
		.out3   (demux_result_to_c21_reg), 
		.out4   (demux_result_to_c22_reg)
	);
	
	// demux register enable signal
	one_to_four_demux_gatelevel_module eight_bit_one_to_four_demux_c_reg(
		.a      (input_demux_c_reg), 
		.s0     (sel_en_demux_c_reg[0]), 
		.s1     (sel_en_demux_c_reg[1]),
		.out1   (en_c11_reg), 
		.out2   (en_c12_reg), 
		.out3   (en_c21_reg), 
		.out4   (en_c22_reg)
	);

	
	// feature out register
	eight_bit_en_register register_c11(.in(demux_result_to_c11_reg), .clk(clk), .en(en_c11_reg), .rst(rst), .out(c11));
	eight_bit_en_register register_c12(.in(demux_result_to_c12_reg), .clk(clk), .en(en_c12_reg), .rst(rst), .out(c12));
	eight_bit_en_register register_c21(.in(demux_result_to_c21_reg), .clk(clk), .en(en_c21_reg), .rst(rst), .out(c21));
	eight_bit_en_register register_c22(.in(demux_result_to_c22_reg), .clk(clk), .en(en_c22_reg), .rst(rst), .out(c22));

endmodule
