module Top_SA_Data_Loader(
    input clk,
    input rst,
    input Weight_Preloader_en,
    input Feature_Loader_en,
    input [5:0] feature_baseaddr,
    input mode,
    input [2:0] c_sel,
    output is_FL_done_o,
    output is_WL_done_o,
    
    output [2:0] c_sel_d,
    output [7:0] feature_1,
    output [7:0] feature_2,
    output [7:0] feature_3,
    output sa_reg_en,
    output sa_en,
    output [7:0] preload_weight_1,
    output [7:0] preload_weight_2,
    output [7:0] preload_weight_3,
    output [7:0] preload_weight_4,
    output [7:0] preload_weight_5,
    output [7:0] preload_weight_6,
    output [7:0] preload_weight_7,
    output [7:0] preload_weight_8,
    output [7:0] preload_weight_9,
    output [8:0] preload_ens
);
    wire [5:0] feature_addr;
    wire [5:0] weight_addr;
    wire [7:0] weight_q;
    wire [7:0] feature_q;
    wire mode_d;
    wire [5:0] addr;
    wire [7:0] q;
    wire [2:0] c_sel_1_d;
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
    three_bit_d_flip_flop three_bit_d_flip_flop_1(
        .d(c_sel), 
        .clk(clk), 
        .q(c_sel_1_d), 
        .q_bar()
    );
    three_bit_d_flip_flop three_bit_d_flip_flop_2(
        .d(c_sel_1_d), 
        .clk(clk), 
        .q(c_sel_d), 
        .q_bar()
    );
    single_port_ram ram(
	.data(),
	.addr(addr),
	.we(1'b0), 
    .clk(clk),
	.q(q)
    );
endmodule