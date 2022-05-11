module systolic_array_tb;
 
    reg [7:0] row1_in, row2_in, row3_in, col1_in, col2_in, col3_in;
    reg clk, rst, en_reg_A, en_reg_B, en_reg_Add, en_reg_Acc;
    wire [7:0] result;

	
    

systolic_array sys_array(.clk(clk), .rst(rst), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B), .en_reg_Add(en_reg_Add), .en_reg_Acc(en_reg_Acc), .row1_in(row1_in), .row2_in(row2_in), .row3_in(row3_in), .col1_in(col1_in), .col2_in(col2_in), .col3_in(col3_in), .result(result));

    always #5 clk = ~clk;
    initial begin
        // serial mode on, parallel mode off
        #0 clk = 0; rst = 1; en_reg_Acc = 0;  en_reg_A=0; en_reg_B=1; en_reg_Add=0;
           row1_in=8'd0; row2_in=8'd0; row3_in=8'd0; col1_in=8'd1; col2_in=8'd2; col3_in=8'd3;
           
   	#6 rst=0;
	#10 en_reg_B = 0; en_reg_A = 1; en_reg_Add = 1;
	// c11
	#7 col1_in=8'd0; col2_in=8'd0; col3_in=8'd0;
	   row1_in=8'd1; row2_in=8'd0; row3_in=8'd0;
	#10 row1_in=8'd1; row2_in=8'd2; row3_in=8'd0;
	#10 row1_in=8'd1; row2_in=8'd2; row3_in=8'd3;
	#10 row1_in=8'd0; row2_in=8'd2; row3_in=8'd3;
	#10 row1_in=8'd0; row2_in=8'd0; row3_in=8'd3;
	
	// c12
	#10 row1_in=8'd2; row2_in=8'd0; row3_in=8'd0;
	#10 row1_in=8'd2; row2_in=8'd3; row3_in=8'd0;
	#10 row1_in=8'd2; row2_in=8'd3; row3_in=8'd4;
	#10 row1_in=8'd0; row2_in=8'd3; row3_in=8'd4;
	#10 row1_in=8'd0; row2_in=8'd0; row3_in=8'd4;

	// c21
	#10 row1_in=8'd1; row2_in=8'd0; row3_in=8'd0;
	#10 row1_in=8'd1; row2_in=8'd2; row3_in=8'd0;
	#10 row1_in=8'd1; row2_in=8'd2; row3_in=8'd3;
	#10 row1_in=8'd0; row2_in=8'd2; row3_in=8'd3;
	#10 row1_in=8'd0; row2_in=8'd0; row3_in=8'd3;

	// c22
	#10 row1_in=8'd2; row2_in=8'd0; row3_in=8'd0;
	#10 row1_in=8'd2; row2_in=8'd3; row3_in=8'd0;
	#10 row1_in=8'd2; row2_in=8'd3; row3_in=8'd4;
	#10 row1_in=8'd0; row2_in=8'd3; row3_in=8'd4;
	#10 row1_in=8'd0; row2_in=8'd0; row3_in=8'd4;



end
    
endmodule