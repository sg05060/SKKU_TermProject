module four_bit_d_flip_flop(
    input           clk,
    input   [3:0]   d,
    output  [3:0]   q,
    output  [3:0]   q_bar
);

    d_flip_flop_behavioral_module d_flip_flop_behavioral_module_inst_0(.clk(clk), .d([0]), .q(q[0]), .q_bar(q_bar[0]));
    d_flip_flop_behavioral_module d_flip_flop_behavioral_module_inst_1(.clk(clk), .d([1]), .q(q[1]), .q_bar(q_bar[1]));
    d_flip_flop_behavioral_module d_flip_flop_behavioral_module_inst_2(.clk(clk), .d([2]), .q(q[2]), .q_bar(q_bar[2]));
    d_flip_flop_behavioral_module d_flip_flop_behavioral_module_inst_3(.clk(clk), .d([3]), .q(q[3]), .q_bar(q_bar[3]));

endmodule
