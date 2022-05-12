module PE_tb;
    reg clk;
    reg rst;
    reg en_reg_A, en_reg_B, en_reg_Add, en_reg_Acc;
    reg [7:0] a_in, b_in, y_in;
    wire [7:0] y_out, a_out, s_mode_out;
    

PE  PE1(.a_in(a_in), .b_in(b_in), .y_in(y_in), .en_reg_A(en_reg_A), .en_reg_B(en_reg_B), .en_reg_Add(en_reg_Add), .en_reg_Acc(en_reg_Acc), .clk(clk), .rst(rst), .y_out(y_out), .a_out(a_out), .s_mode_out(s_mode_out));


    always #5 clk = ~clk;
    initial begin
        // serial mode on, parallel mode off
        #0 clk = 0; rst = 1; en_reg_Acc = 1;  en_reg_A=0; en_reg_B=0; en_reg_Add=0; y_in=8'b0;
           a_in = 8'd1; b_in=8'd1;
    #6 rst=0;
        //c11
        #5 a_in = 8'd1; b_in=8'd1;
        #10 a_in = 8'd2; b_in=8'd1;
        #10 a_in = 8'd3; b_in=8'd1;
        #10 a_in = 8'd1; b_in=8'd2;
        #10 a_in = 8'd2; b_in=8'd2;
        #10 a_in = 8'd3; b_in=8'd2;
        #10 a_in = 8'd1; b_in=8'd3;
        #10 a_in = 8'd2; b_in=8'd3;
        #10 a_in = 8'd3; b_in=8'd3;
        //c12
        #10 a_in = 8'd2; b_in=8'd1;
        #10 a_in = 8'd3; b_in=8'd1;
        #10 a_in = 8'd4; b_in=8'd1;
        #10 a_in = 8'd2; b_in=8'd2;
        #10 a_in = 8'd3; b_in=8'd2;
        #10 a_in = 8'd4; b_in=8'd2;
        #10 a_in = 8'd2; b_in=8'd3;
        #10 a_in = 8'd3; b_in=8'd3;
        #10 a_in = 8'd4; b_in=8'd3;
        //c21
        #10 a_in = 8'd1; b_in=8'd1;
        #10 a_in = 8'd2; b_in=8'd1;
        #10 a_in = 8'd3; b_in=8'd1;
        #10 a_in = 8'd1; b_in=8'd2;
        #10 a_in = 8'd2; b_in=8'd2;
        #10 a_in = 8'd3; b_in=8'd2;
        #10 a_in = 8'd1; b_in=8'd3;
        #10 a_in = 8'd2; b_in=8'd3;
        #10 a_in = 8'd3; b_in=8'd3;
        //c22
        #10 a_in = 8'd2; b_in=8'd1;
        #10 a_in = 8'd3; b_in=8'd1;
        #10 a_in = 8'd4; b_in=8'd1;
        #10 a_in = 8'd2; b_in=8'd2;
        #10 a_in = 8'd3; b_in=8'd2;
        #10 a_in = 8'd4; b_in=8'd2;
        #10 a_in = 8'd2; b_in=8'd3;
        #10 a_in = 8'd3; b_in=8'd3;
        #10 a_in = 8'd4; b_in=8'd3;
        
        // serial mode off, parallel mode on
        #10 en_reg_Acc = 0; en_reg_B = 1;
        #10 en_reg_A = 1; en_reg_Add = 1;
            a_in = 8'd2; b_in = 8'd3; y_in = 8'd5;
        #20 en_reg_A = 0; en_reg_B = 0; en_reg_Add = 0;



end
    
endmodule
