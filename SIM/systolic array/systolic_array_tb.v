module systolic_array_tb;
 
	reg [8:0] en_reg_B;
    reg [7:0] row1_in, row2_in, row3_in, B11, B12, B13, B21, B22, B23, B31, B32, B33;
	reg [1:0] sel_en_demux_result, sel_en_demux_c_reg;
    reg clk, rst, en_reg_A, en_reg_Acc, input_demux_c_reg;
    wire [7:0] c11, c12, c21, c22;

systolic_array sys_array(.clk(clk), .rst(rst), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B), .en_reg_Acc(en_reg_Acc), 
.B11(B11), .B12(B12), .B13(B13), .B21(B21),. B22(B22), .B23(B23), .B31(B31), .B32(B32), .B33(B33), 
.sel_en_demux_result(sel_en_demux_result), .input_demux_c_reg(input_demux_c_reg), .sel_en_demux_c_reg(sel_en_demux_c_reg),
.row1_in(row1_in), .row2_in(row2_in), .row3_in(row3_in),
.c11(c11), .c12(c12), .c21(c21), .c22(c22));

    always #5 clk = ~clk;
    initial begin
        // serial mode on, parallel mode off
        #0 clk = 0; rst = 1; en_reg_Acc = 0;  en_reg_A=0; en_reg_B=9'b111111111;
           row1_in=8'd0; row2_in=8'd0; row3_in=8'd0;
		   B11 = 8'd1; B12 = 8'd2; B13 = 8'd3; B21 = 8'd1; B22 = 8'd2; B23 = 8'd3; B31 = 8'd1; B32 = 8'd2; B33 = 8'd3;
		   input_demux_c_reg = 1'b1; sel_en_demux_result = 2'b00; sel_en_demux_c_reg = 2'b00;
           
   	#6 rst=0;
	#10 en_reg_B = 9'b000000000; en_reg_A = 1;
	// c11
	#7 row1_in=8'd1; row2_in=8'd0; row3_in=8'd0;
	#10 row1_in=8'd1; row2_in=8'd2; row3_in=8'd0;
	#10 row1_in=8'd1; row2_in=8'd2; row3_in=8'd3;
	#10 row1_in=8'd0; row2_in=8'd2; row3_in=8'd3;
	#10 row1_in=8'd0; row2_in=8'd0; row3_in=8'd3;
	
	// c12
	#10 row1_in=8'd2; row2_in=8'd0; row3_in=8'd0; //73ns
	#3 sel_en_demux_result = 2'b01; sel_en_demux_c_reg = 2'b01; //76ns
	#7 row1_in=8'd2; row2_in=8'd3; row3_in=8'd0;
	#10 row1_in=8'd2; row2_in=8'd3; row3_in=8'd4;
	#10 row1_in=8'd0; row2_in=8'd3; row3_in=8'd4;
	#10 row1_in=8'd0; row2_in=8'd0; row3_in=8'd4;

	// c21
	#10 row1_in=8'd1; row2_in=8'd0; row3_in=8'd0;
	#3 sel_en_demux_result = 2'b10; sel_en_demux_c_reg = 2'b10;
	#7 row1_in=8'd1; row2_in=8'd2; row3_in=8'd0;
	#10 row1_in=8'd1; row2_in=8'd2; row3_in=8'd3;
	#10 row1_in=8'd0; row2_in=8'd2; row3_in=8'd3;
	#10 row1_in=8'd0; row2_in=8'd0; row3_in=8'd3;

	// c22
	#10 row1_in=8'd2; row2_in=8'd0; row3_in=8'd0;
	#3 sel_en_demux_result = 2'b11; sel_en_demux_c_reg = 2'b11;
	#7 row1_in=8'd2; row2_in=8'd3; row3_in=8'd0;
	#10 row1_in=8'd2; row2_in=8'd3; row3_in=8'd4;
	#10 row1_in=8'd0; row2_in=8'd3; row3_in=8'd4;
	#10 row1_in=8'd0; row2_in=8'd0; row3_in=8'd4;

	#13 input_demux_c_reg = 1'b0;



end
    
endmodule