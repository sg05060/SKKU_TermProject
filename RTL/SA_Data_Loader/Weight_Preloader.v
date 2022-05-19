module Weight_Preloader(
    input clk,
    input rst,
    input en,
    input [7:0] q,

    output is_done_o,
    output [5:0] addr,
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
    wire [7:0] cnt;
    wire en_d;
    wire [3:0] sel;
    wire preload_en;
    custom_ring_couter counter(
        .clk            (clk), 
        .rst            (rst), 
        .en             (en),
        .i_num_cnt      (8'b0000_1001), 
        .out            (cnt), 
        .is_done_o      (is_done_o)
    );

    // make preload_ens
    d_flip_flop_behavioral_module d_flip_flop_1(
        .d(en), 
        .clk(clk), 
        .q(en_d), 
        .q_bar()
    );
    and_gate and_gate_1(
        .a(en_d), 
        .b(1'b1), 
        .out(preload_en)
    ); 
    one_to_nine_demux_gatelevel_module one_to_nine_demux_1 (
        .a(preload_en), 
        .s(sel), 
        .out1(preload_ens[0]),
        .out2(preload_ens[1]),
        .out3(preload_ens[2]),
        .out4(preload_ens[3]),
        .out5(preload_ens[4]),
        .out6(preload_ens[5]),
        .out7(preload_ens[6]),
        .out8(preload_ens[7]),
        .out9(preload_ens[8])
    );

    // make cnt_delay for mux's sel
    four_bit_d_flip_flop four_bit_d_flip_flop_1(
        .d(cnt[3:0]),
        .clk(clk),
        .q(sel),
        .q_bar()
    );

    // preload_data
    eight_bit_one_to_nine_demux_gatelevel_module eight_bit_one_to_nine_demux(
        .a(q),
        .s(sel), 
        .out1(preload_weight_1),
        .out2(preload_weight_2),
        .out3(preload_weight_3),
        .out4(preload_weight_4),
        .out5(preload_weight_5),
        .out6(preload_weight_6),
        .out7(preload_weight_7),
        .out8(preload_weight_8),
        .out9(preload_weight_9)
    );
    SA_weight_address_decoder SA_weight_address_decoder(
        .cnt(cnt[3:0]),
        .addr(addr)
    );

endmodule