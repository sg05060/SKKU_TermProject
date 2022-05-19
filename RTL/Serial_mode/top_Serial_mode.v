module top_serial_mode (
    input clk,
    input rst,
    input en,
    input [7:0] feature_baseaddr,

    output is_done_o,
    output [7:0] out
);

    wire we;
    wire [7:0] w_out;
    wire [7:0] f_out;
    wire       acc_en;
    wire    [7:0]   q;
    wire [5:0] addr;
    Serial_Data_loader Serial_Data_loader(
        .clk(clk),
        .rst(rst),
        .en(en),
        .feature_baseaddr(feature_baseaddr),     
        .q(q),
        .is_done_o(is_done_o),
        .we(we),
        .addr(addr),        
        .w_out(w_out),
        .f_out(f_out),
        .acc_en(acc_en)
    );
    /*
    acc_test acc_test(
        .clk(clk),
        .w_out(w_out),
        .f_out(f_out),
        .rst(rst),
        .en(acc_en),
        .out(out)
    );
    */
    PE PE(
        .a_in(f_out),
        .b_in(w_out), 
        .y_in(),
        .en_reg_A(),
        .en_reg_B(), 
        //.en_reg_Add(), 
        .en_Acc(acc_en), 
        .clk(clk), 
        .rst(rst), 
        .y_out(), 
        .a_out(), 
        .s_mode_out()
        );


    single_port_ram ram(
	.data(),
	.addr(addr),
	.we(we), 
    .clk(clk),
	.q(q)
    );
endmodule
