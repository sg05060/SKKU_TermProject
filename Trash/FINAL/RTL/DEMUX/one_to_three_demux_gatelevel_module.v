module one_to_three_demux_gatelevel_module(
    input a,
    input [1:0] sel,
    output wire out1,
    output wire out2,
    output wire out3
);
    one_to_four_demux_gatelevel_module one_to_four_demux(
        .a(a), 
        .s0(sel[0]), 
        .s1(sel[1]), 
        .out1(out1), 
        .out2(out2), 
        .out3(out3), 
        .out4()
    );

endmodule