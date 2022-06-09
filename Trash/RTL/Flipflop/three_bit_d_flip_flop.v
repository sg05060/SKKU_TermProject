module three_bit_d_flip_flop(d,clk,q,q_bar);
    input [2:0] d;
    input clk;
    output [2:0] q;
    output [2:0] q_bar;

    d_flip_flop_behavioral_module d_flip_flop_behavioral_module_inst_0(.d(d[0]), .clk(clk), .q(q[0]), .q_bar(q_bar[0]));
    d_flip_flop_behavioral_module d_flip_flop_behavioral_module_inst_1(.d(d[1]), .clk(clk), .q(q[1]), .q_bar(q_bar[1]));
    d_flip_flop_behavioral_module d_flip_flop_behavioral_module_inst_2(.d(d[2]), .clk(clk), .q(q[2]), .q_bar(q_bar[2]));
endmodule
