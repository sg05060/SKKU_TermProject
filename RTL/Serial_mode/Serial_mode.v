module Serial_mode (
    input clk,
    input rst,
    input en,
    input [7:0] feature_baseaddr,
    input [7:0] q,

    output [5:0] addr,
    output we,
    output is_done_o,
    output [7:0] out
);

    wire [7:0] w_out;
    wire [7:0] f_out;
    wire       acc_en;
    wire       rst_pe;

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
        .acc_en(acc_en),
        .rst_pe(rst_pe)
    );
    PE PE(
        .a_in(f_out),
        .b_in(w_out), 
        .y_in(),
        .en_reg_A(),
        .en_reg_B(), 
        //.en_reg_Add(), 
        .en_reg_Acc(acc_en), 
        .clk(clk), 
        .rst(rst_pe), 
        .y_out(), 
        .a_out(), 
        .s_mode_out(out)
    );
endmodule
