module Feature_Loader (
    input clk,
    input rst,
    input en,
    input [7:0] q,
    input [5:0] feature_baseaddr,

    output [5:0] addr,
    output [7:0] feature_1,
    output [7:0] feature_2,
    output [7:0] feature_3,
    output wire sa_en
);
    wire [7:0] cnt;
    wire [3:0] cnt_d;
    wire [1:0] two_bit_sel; 
    wire [2:0] three_bit_sel;
    wire [2:0] three_bit_en;
    wire w_sa_en;
    wire [5:0] offset_addr;
    wire [7:0] out1,out2,out3;
    wire [7:0] i_reg_1,i_reg_2,i_reg_3;
    custom_ring_couter counter(
        .clk            (clk), 
        .rst            (rst), 
        .en             (en),
        .i_num_cnt      (8'b0001_0010), 
        .out            (cnt), 
        .is_done_o      (is_done_o)
    );

    //make addr
    SA_feature_address_decoder SA_feature_address_decoder(
        .cnt(cnt[3:0]),
        .addr(offset_addr)
    );
    eight_bit_full_adder_module eight_bit_full_adder_module(
        .a({2'b0,offset_addr}), 
        .b({2'b0,feature_baseaddr}), 
        .cin(1'b0), 
        .sum(addr), 
        .cout()
    );

    four_bit_d_flip_flop four_bit_d_flip_flop_1(
        .d(cnt[3:0]),
        .clk(clk),
        .q(cnt_d),
        .q_bar()
    );

    SA_3_to_1_MUX_SEL_Decoder SA_3_to_1_MUX_SEL(
        .cnt(cnt_d),
        .sel(two_bit_sel)
    );
    SA_2_to_1_MUX_SEL_Decoder SA_2_to_1_MUX_SEL(
        .cnt(cnt_d),
        .sel(three_bit_sel)
    );
    SA_3_bit_en_Decoder SA_3_bit_en_Decoder(
        .cnt(cnt_d),
        .en(three_bit_en)
    );

    // mux flow
    eight_bit_one_to_three_demux_gatelevel_module eight_bit_one_to_three_demux_gatelevel_module(
        .a(q),
        .sel(two_bit_sel),
        .out1(out1),
        .out2(out2),
        .out3(out3)
    );
    eight_bit_two_to_one_mux_gatelevel_module eight_bit_two_to_one_mux_gatelevel_1(
            .a(out1), 
            .b(8'b0), 
            .s(three_bit_sel[0]), 
            .out(i_reg_1)
    );
    eight_bit_two_to_one_mux_gatelevel_module eight_bit_two_to_one_mux_gatelevel_2(
            .a(out2), 
            .b(8'b0), 
            .s(three_bit_sel[1]), 
            .out(i_reg_2)
    );
    eight_bit_two_to_one_mux_gatelevel_module eight_bit_two_to_one_mux_gatelevel_3(
            .a(out3), 
            .b(8'b0), 
            .s(three_bit_sel[2]), 
            .out(i_reg_3)
    );
    eight_bit_en_register eight_bit_en_register_1(
        .in(i_reg_1), 
        .clk(clk), 
        .en(three_bit_en[0]), 
        .rst(rst), 
        .out(feature_1)
    );
    eight_bit_en_register eight_bit_en_register_2(
        .in(i_reg_2), 
        .clk(clk), 
        .en(three_bit_en[1]), 
        .rst(rst), 
        .out(feature_2)
    );
   
   eight_bit_en_register eight_bit_en_register_3(
        .in(i_reg_3), 
        .clk(clk), 
        .en(three_bit_en[2]), 
        .rst(rst), 
        .out(feature_3)
    );
   
   


    SA_register_en_Decoder SA_register_en_Decoder(
        .cnt(cnt_d),
        .en(w_sa_en)
    );
    d_flip_flop_behavioral_module d_flip_flop_1 (
        .d(w_sa_en), 
        .clk(clk), 
        .q(sa_en), 
        .q_bar()
    );

endmodule