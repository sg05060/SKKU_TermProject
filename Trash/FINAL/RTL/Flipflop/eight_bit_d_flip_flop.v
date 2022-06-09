module eight_bit_d_flip_flop(d,clk,q,q_bar);
    input [7:0] d;
    input clk;
    output [7:0] q;
    output [7:0] q_bar;

    d_flip_flop_behavioral_module d_flip_flop_behavioral_module_inst_0(.d(d[0]), .clk(clk), .q(q[0]), .q_bar(q_bar[0]));
    d_flip_flop_behavioral_module d_flip_flop_behavioral_module_inst_1(.d(d[1]), .clk(clk), .q(q[1]), .q_bar(q_bar[1]));
    d_flip_flop_behavioral_module d_flip_flop_behavioral_module_inst_2(.d(d[2]), .clk(clk), .q(q[2]), .q_bar(q_bar[2]));
    d_flip_flop_behavioral_module d_flip_flop_behavioral_module_inst_3(.d(d[3]), .clk(clk), .q(q[3]), .q_bar(q_bar[3]));
    d_flip_flop_behavioral_module d_flip_flop_behavioral_module_inst_4(.d(d[4]), .clk(clk), .q(q[4]), .q_bar(q_bar[4]));
    d_flip_flop_behavioral_module d_flip_flop_behavioral_module_inst_5(.d(d[5]), .clk(clk), .q(q[5]), .q_bar(q_bar[5]));
    d_flip_flop_behavioral_module d_flip_flop_behavioral_module_inst_6(.d(d[6]), .clk(clk), .q(q[6]), .q_bar(q_bar[6]));
    d_flip_flop_behavioral_module d_flip_flop_behavioral_module_inst_7(.d(d[7]), .clk(clk), .q(q[7]), .q_bar(q_bar[7]));
endmodule
