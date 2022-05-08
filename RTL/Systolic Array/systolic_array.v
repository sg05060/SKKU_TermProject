module systolic_array(clk, rst, en_reg_A, en_reg_B, en_reg_Add, en_reg_Acc, row1_in, row2_in, row3_in, col1_in, col2_in, col3_in, result);

	input [7:0] row1_in, row2_in, row3_in, col1_in, col2_in, col3_in;
    input clk, rst, en_reg_A, en_reg_B, en_reg_Add, en_reg_Acc;
	output [7:0] result;

	wire [7:0] wire_A [5:0];
	wire [7:0] wire_B [8:0];
	wire [7:0] adder_sum;

	// 3x3 PE structure
	PE pe1(.a_in(row1_in), .b_in(), .y_in(col1_in), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B), .en_reg_Add(en_reg_Add), .en_Acc(en_reg_Acc),
		   .clk(clk), .rst(rst), .y_out(wire_B[0]), .a_out(wire_A[0]), .s_mode_out());
	PE pe2(.a_in(wire_A[0]), .b_in(), .y_in(col2_in), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B), .en_reg_Add(en_reg_Add), .en_Acc(en_reg_Acc),
		   .clk(clk), .rst(rst), .y_out(wire_B[1]), .a_out(wire_A[1]), .s_mode_out());
	PE pe3(.a_in(wire_A[1]), .b_in(), .y_in(col3_in), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B), .en_reg_Add(en_reg_Add), .en_Acc(en_reg_Acc),
		   .clk(clk), .rst(rst), .y_out(wire_B[2]), .a_out(), .s_mode_out());
	PE pe4(.a_in(row2_in), .b_in(), .y_in(wire_B[0]), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B), .en_reg_Add(en_reg_Add), .en_Acc(en_reg_Acc),
		   .clk(clk), .rst(rst), .y_out(wire_B[3]), .a_out(wire_A[2]), .s_mode_out());
	PE pe5(.a_in(wire_A[2]), .b_in(), .y_in(wire_B[1]), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B), .en_reg_Add(en_reg_Add), .en_Acc(en_reg_Acc),
		   .clk(clk), .rst(rst), .y_out(wire_B[4]), .a_out(wire_A[3]), .s_mode_out());
	PE pe6(.a_in(wire_A[3]), .b_in(), .y_in(wire_B[2]), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B), .en_reg_Add(en_reg_Add), .en_Acc(en_reg_Acc),
		   .clk(clk), .rst(rst), .y_out(wire_B[5]), .a_out(), .s_mode_out());
	PE pe7(.a_in(row3_in), .b_in(), .y_in(wire_B[3]), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B), .en_reg_Add(en_reg_Add), .en_Acc(en_reg_Acc),
		   .clk(clk), .rst(rst), .y_out(wire_B[6]), .a_out(wire_A[4]), .s_mode_out());
	PE pe8(.a_in(wire_A[4]), .b_in(), .y_in(wire_B[4]), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B), .en_reg_Add(en_reg_Add), .en_Acc(en_reg_Acc),
		   .clk(clk), .rst(rst), .y_out(wire_B[7]), .a_out(wire_A[5]), .s_mode_out());
	PE pe9(.a_in(wire_A[5]), .b_in(), .y_in(wire_B[5]), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B), .en_reg_Add(en_reg_Add), .en_Acc(en_reg_Acc),
		   .clk(clk), .rst(rst), .y_out(wire_B[8]), .a_out(), .s_mode_out());	



//adder
eight_bit_full_adder_module eight_bit_adder1(.a(wire_B[6]), .b(wire_B[7]), .cin(1'b0), .sum(adder_sum), .cout());
eight_bit_full_adder_module eight_bit_adder2(.a(adder_sum), .b(wire_B[8]), .cin(1'b0), .sum(result), .cout());


endmodule
