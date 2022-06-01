module Systolic_mode(

    input clk,
    input rst,
    input Weight_Preloader_en,
    input Feature_Loader_en,
    input [5:0] feature_baseaddr,
    input mode,
    input [1:0] c_sel,
    input [7:0] q,

    output [5:0] addr,
    output is_FL_done_o,
    output is_WL_done_o,
    output [7:0] c11,
    output [7:0] c12,
    output [7:0] c21,
    output [7:0] c22

);  
    wire [5:0] feature_addr;
    wire [5:0] weight_addr;
    wire [7:0] weight_q;
    wire [7:0] feature_q;
    wire mode_d;
    wire [1:0] c_sel_1_d;
    wire [1:0] c_sel_2_d;
    wire [1:0] c_sel_d;
    wire [7:0] feature_1;
    wire [7:0] feature_2;
    wire [7:0] feature_3;
    wire sa_reg_en;
    wire sa_en;
    wire [7:0] preload_weight_1;
    wire [7:0] preload_weight_2;
    wire [7:0] preload_weight_3;
    wire [7:0] preload_weight_4;
    wire [7:0] preload_weight_5;
    wire [7:0] preload_weight_6;
    wire [7:0] preload_weight_7;
    wire [7:0] preload_weight_8;
    wire [7:0] preload_weight_9;
    wire [8:0] preload_ens;
    
    Feature_Loader Feature_Loader(
        .clk(clk),
        .rst(rst),
        .en(Feature_Loader_en),
        .q(feature_q),
        .feature_baseaddr(feature_baseaddr),

        .addr(feature_addr),
        .feature_1(feature_1),
        .feature_2(feature_2),
        .feature_3(feature_3),
        .is_done_o(is_FL_done_o),
        .sa_reg_en(sa_reg_en),
        .sa_en(sa_en)
    );
    Weight_Preloader Weight_Preloader(
        .clk(clk),
        .rst(rst),
        .en(Weight_Preloader_en),
        .q(weight_q),

        .is_done_o(is_WL_done_o),
        .addr(weight_addr),
        .preload_weight_1(preload_weight_1),
        .preload_weight_2(preload_weight_2),
        .preload_weight_3(preload_weight_3),
        .preload_weight_4(preload_weight_4),
        .preload_weight_5(preload_weight_5),
        .preload_weight_6(preload_weight_6),
        .preload_weight_7(preload_weight_7),
        .preload_weight_8(preload_weight_8),
        .preload_weight_9(preload_weight_9),
        .preload_ens(preload_ens) 
    );

    six_bit_two_to_one_mux_gatelevel_module six_bit_two_to_one_mux(
        .a(weight_addr),
        .b(feature_addr),
        .s(mode),
        .out(addr)
    );
    eight_bit_one_to_two_mux_gatelevel_module eight_bit_one_to_two_mux(
        .a(q),
        .s(mode_d),
        .out1(weight_q),
        .out2(feature_q)
    );
    
    d_flip_flop_behavioral_module d_flip_flop_2 (
        .d(mode), 
        .clk(clk), 
        .q(mode_d), 
        .q_bar()
    );

    two_bit_d_flip_flop two_bit_d_flip_flop_1(
        .d(c_sel), 
        .clk(clk), 
        .q(c_sel_1_d), 
        .q_bar()
    );

    two_bit_d_flip_flop two_bit_d_flip_flop_2(
        .d(c_sel_1_d), 
        .clk(clk), 
        .q(c_sel_2_d), 
        .q_bar()
    );

    two_bit_d_flip_flop two_bit_d_flip_flop_3(
        .d(c_sel_2_d),
        .clk(clk), 
        .q(c_sel_d), 
        .q_bar()
    );

    
    systolic_array sa(
        .clk(clk), 
        .rst(rst), 
        .en_reg_A(sa_en), 
        .en_reg_B(preload_ens), 
        .en_reg_Acc(), 
        .B11(preload_weight_1), 
        .B12(preload_weight_2), 
        .B13(preload_weight_3), 
        .B21(preload_weight_4), 
        .B22(preload_weight_5), 
        .B23(preload_weight_6), 
        .B31(preload_weight_7), 
        .B32(preload_weight_8), 
        .B33(preload_weight_9), 
        .sel_en_demux_result(c_sel_d), 
        .input_demux_c_reg(sa_reg_en), 
        .sel_en_demux_c_reg(c_sel_d),
        .row1_in(feature_1),
        .row2_in(feature_2),
        .row3_in(feature_3),
        .c11(c11), 
        .c12(c12), 
        .c21(c21), 
        .c22(c22)
    );

endmodule