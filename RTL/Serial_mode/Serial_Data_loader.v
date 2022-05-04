module Serial_Data_loader (
    input           clk,
    input           rst,
    input           en,
    input   [7:0]   feature_baseaddr,

    input   [7:0]   q,

    output          is_done_o,
    output          we,
    output  [5:0]   addr,

    output  [7:0]   w_out,
    output  [7:0]   f_out,
    output  wire    acc_en
);

    wire    [7:0]   cnt;
    wire    [7:0]   wire_addr;
    wire    [7:0]   jump_addr_one;
    wire    [7:0]   jump_addr_two;
    wire    [7:0]   a_addr_offset;
    wire    [7:0]   xnor_out;
    wire    [6:0]        sel_offset_0;
    wire    [6:0]        sel_offset_1;
    wire    [7:0]   a_addr;
    wire            sel_q;
    wire     [7:0]   r_w_out;

    assign sel_offset_0 = cnt[7:1] - 7'b0000_011;
    assign sel_offset_1 = cnt[7:1] - 7'b0000_110;
    custom_ring_couter counter(
        .clk            (clk), 
        .rst            (rst), 
        .en             (en),
        .i_num_cnt      (8'b0001_0010), 
        .out            (cnt), 
        .is_done_o      (is_done_o)
    );

    eight_bit_full_adder_module adder_1(
        .a              ({1'b0,cnt[7:1]}),
        .b              (8'b0000_0001),
        .cin            (1'b0), 
        .sum            (jump_addr_one), 
        .cout           ()
    );

    eight_bit_full_adder_module adder_2(
        .a              ({1'b0,cnt[7:1]}),
        .b              (8'b0000_0010),
        .cin            (1'b0), 
        .sum            (jump_addr_two), 
        .cout           ()
    );

    eight_bit_xnor_gate eight_bit_xnor_gate_inst(
        .a({5'b0,cnt[3:1]}), 
        .b(8'b0000_0111), 
        .out(xnor_out)
    );

    eight_bit_wise_and_gate eight_bit_wise_and_gate_inst(
        .a(xnor_out),
        .out(sel_offset)
    );

    eight_bit_four_to_one_mux_gatelevel_module four_to_one_mux1(
        .a              (jump_addr_two), 
        .b              (),
        .c              (jump_addr_one),
        .d              ({1'b0,cnt[7:1]}), 
        .s0             (sel_offset_0[6]),
        .s1             (sel_offset_1[6]),
        .out            (a_addr_offset)
    );

    eight_bit_full_adder_module adder_3(
        .a              (feature_baseaddr),
        .b              (a_addr_offset),
        .cin            (1'b0), 
        .sum            (a_addr), 
        .cout           ()
    );

    eight_bit_two_to_one_mux_gatelevel_module two_to_one_mux2(
        .a              ({1'b0,cnt[7:1]}), 
        .b              (a_addr), 
        .s              (cnt[0]),
        .out            (wire_addr)
    );

    d_flip_flop_behavioral_module d_flip_flop_1(
        .d(cnt[0]), 
        .clk(clk), 
        .q(sel_q), 
        .q_bar()
    );

    eight_bit_one_to_two_mux_gatelevel_module eight_bit_one_to_two_mux_gatelevel_module_1(
        .a(q),
        .s(sel_q),
        .out1(r_w_out),
        .out2(f_out)
    );

    eight_bit_d_flip_flop d_flip_flop_2(
        .d(r_w_out), 
        .clk(clk), 
        .q(w_out), 
        .q_bar()
    );

    assign addr = wire_addr[5:0];
    assign we   = 1'b0;
    assign acc_en = sel_q;

endmodule
