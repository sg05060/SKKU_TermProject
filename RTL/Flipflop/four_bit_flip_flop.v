module four_bit_d_flip_flop(d,clk,q,q_bar);
    input [3:0] d;
    input clk;
    output [3:0] q;
    output [3:0] q_bar;

    d_flip_flop_behavioral_module d_flip_flop_behavioral_module_inst_0(.d(d[0]), .clk(clk), .q(q[0]), .q_bar(q_bar[0]));
    d_flip_flop_behavioral_module d_flip_flop_behavioral_module_inst_1(.d(d[1]), .clk(clk), .q(q[1]), .q_bar(q_bar[1]));
    d_flip_flop_behavioral_module d_flip_flop_behavioral_module_inst_2(.d(d[2]), .clk(clk), .q(q[2]), .q_bar(q_bar[2]));
    d_flip_flop_behavioral_module d_flip_flop_behavioral_module_inst_3(.d(d[3]), .clk(clk), .q(q[3]), .q_bar(q_bar[3]));
endmodule
