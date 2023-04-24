module eight_bit_one_to_three_demux_gatelevel_module(
    input [7:0] a,
    input [1:0] sel,
    output [7:0] out1,
    output [7:0] out2,
    output [7:0] out3
);
    one_to_three_demux_gatelevel_module one_to_three_demux_1(
        .a(a[0]),
        .sel(sel),
        .out1(out1[0]),
        .out2(out2[0]),
        .out3(out3[0])
    );
    one_to_three_demux_gatelevel_module one_to_three_demux_2(
        .a(a[1]),
        .sel(sel),
        .out1(out1[1]),
        .out2(out2[1]),
        .out3(out3[1])
    );
    one_to_three_demux_gatelevel_module one_to_three_demux_3(
        .a(a[2]),
        .sel(sel),
        .out1(out1[2]),
        .out2(out2[2]),
        .out3(out3[2])
    );
    one_to_three_demux_gatelevel_module one_to_three_demux_4(
        .a(a[3]),
        .sel(sel),
        .out1(out1[3]),
        .out2(out2[3]),
        .out3(out3[3])
    );
    one_to_three_demux_gatelevel_module one_to_three_demux_5(
        .a(a[4]),
        .sel(sel),
        .out1(out1[4]),
        .out2(out2[4]),
        .out3(out3[4])
    );
    one_to_three_demux_gatelevel_module one_to_three_demux_6(
        .a(a[5]),
        .sel(sel),
        .out1(out1[5]),
        .out2(out2[5]),
        .out3(out3[5])
    );
    one_to_three_demux_gatelevel_module one_to_three_demux_7(
        .a(a[6]),
        .sel(sel),
        .out1(out1[6]),
        .out2(out2[6]),
        .out3(out3[6])
    );
    one_to_three_demux_gatelevel_module one_to_three_demux_8(
        .a(a[7]),
        .sel(sel),
        .out1(out1[7]),
        .out2(out2[7]),
        .out3(out3[7])
    );
endmodule