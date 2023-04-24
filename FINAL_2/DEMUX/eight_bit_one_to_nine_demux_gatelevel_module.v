module eight_bit_one_to_nine_demux_gatelevel_module (a, s, out1,out2,out3,out4,out5,out6,out7,out8,out9);
	input [7:0] a;
    input [3:0] s;
    output [7:0] out1;
    output [7:0] out2;
    output [7:0] out3;
    output [7:0] out4;
    output [7:0] out5;
    output [7:0] out6;
    output [7:0] out7;
    output [7:0] out8;
    output [7:0] out9;

    one_to_nine_demux_gatelevel_module demux_1(.a(a[0]), .s(s), .out1(out1[0]),
    .out2(out2[0]), .out3(out3[0]), .out4(out4[0]), .out5(out5[0]), .out6(out6[0]), .out7(out7[0]),
    .out8(out8[0]), .out9(out9[0]));
    one_to_nine_demux_gatelevel_module demux_2(.a(a[1]), .s(s), .out1(out1[1]),
    .out2(out2[1]), .out3(out3[1]), .out4(out4[1]), .out5(out5[1]), .out6(out6[1]), .out7(out7[1]),
    .out8(out8[1]), .out9(out9[1]));
    one_to_nine_demux_gatelevel_module demux_3(.a(a[2]), .s(s), .out1(out1[2]),
    .out2(out2[2]), .out3(out3[2]), .out4(out4[2]), .out5(out5[2]), .out6(out6[2]), .out7(out7[2]),
    .out8(out8[2]), .out9(out9[2]));
    one_to_nine_demux_gatelevel_module demux_4(.a(a[3]), .s(s), .out1(out1[3]),
    .out2(out2[3]), .out3(out3[3]), .out4(out4[3]), .out5(out5[3]), .out6(out6[3]), .out7(out7[3]),
    .out8(out8[3]), .out9(out9[3]));
    one_to_nine_demux_gatelevel_module demux_5(.a(a[4]), .s(s), .out1(out1[4]),
    .out2(out2[4]), .out3(out3[4]), .out4(out4[4]), .out5(out5[4]), .out6(out6[4]), .out7(out7[4]),
    .out8(out8[4]), .out9(out9[4]));
    one_to_nine_demux_gatelevel_module demux_6(.a(a[5]), .s(s), .out1(out1[5]),
    .out2(out2[5]), .out3(out3[5]), .out4(out4[5]), .out5(out5[5]), .out6(out6[5]), .out7(out7[5]),
    .out8(out8[5]), .out9(out9[5]));
    one_to_nine_demux_gatelevel_module demux_7(.a(a[6]), .s(s), .out1(out1[6]),
    .out2(out2[6]), .out3(out3[6]), .out4(out4[6]), .out5(out5[6]), .out6(out6[6]), .out7(out7[6]),
    .out8(out8[6]), .out9(out9[6]));
    one_to_nine_demux_gatelevel_module demux_8(.a(a[7]), .s(s), .out1(out1[7]),
    .out2(out2[7]), .out3(out3[7]), .out4(out4[7]), .out5(out5[7]), .out6(out6[7]), .out7(out7[7]),
    .out8(out8[7]), .out9(out9[7]));
endmodule