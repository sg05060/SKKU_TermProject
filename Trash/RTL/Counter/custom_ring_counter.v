module custom_ring_couter(clk, rst, en, i_num_cnt, out,is_done_o);
    input clk;
    input rst;
    input en;
    input [7:0] i_num_cnt;

    output [7:0] out;
    output is_done_o; 

    wire [7:0] num_cnt;
    wire [7:0] num_cnt_subtract_1;//added
    wire [7:0] reg_out;
    wire [7:0] reg_in;
    wire [7:0] add_out;
    wire [7:0] mux_0_out;
    wire [7:0] xnor_out;
    wire bit_wise_out;
    wire is_done;

    assign is_done_o = is_done;
    assign out = reg_out;
    eight_bit_register_behavioral_module eight_bit_register_behavioral_module_inst (
        .in(reg_in), 
        .clk(clk), 
        .rst(rst), 
        .out(reg_out)
    );
    eight_bit_full_adder_module eight_bit_full_adder_inst (
        .a(reg_out),
        .b(8'b0000_0001), 
        .cin(1'b0), 
        .sum(add_out), 
        .cout()
    );
    eight_bit_two_to_one_mux_gatelevel_module eight_bit_two_to_one_mux_gatelevel_module_inst_0(
        .a(reg_out), 
        .b(add_out), 
        .s(en), 
        .out(mux_0_out)
    );
    eight_bit_two_to_one_mux_gatelevel_module eight_bit_two_to_one_mux_gatelevel_module_inst_1(
        .a(mux_0_out), 
        .b(8'b0), 
        .s(is_done), 
        .out(reg_in)
    );
    // modify!
    eigth_bit_signed_subtractor eigth_bit_signed_subtractor_1(
        .a(num_cnt),
        .b(8'b0000_0001),
        .out(num_cnt_subtract_1)
    );
    eight_bit_xnor_gate eight_bit_xnor_gate_inst(.a(reg_out), .b(num_cnt_subtract_1), .out(xnor_out));
    eight_bit_wise_and_gate eight_bit_wise_and_gate_inst(.a(xnor_out), .out(bit_wise_out));
    and_gate and_gate_inst (.a(bit_wise_out), .b(en), .out(is_done));
    eight_bit_d_flip_flop eight_bit_d_flip_flop_inst(.d(i_num_cnt), .clk(clk), .q(num_cnt), .q_bar());

endmodule
