module one_to_nine_demux_gatelevel_module (a, s, out1,out2,out3,out4,out5,out6,out7,out8,out9);
	input a;
    input [3:0] s;
    output out1;
    output out2;
    output out3;
    output out4;
    output out5;
    output out6;
    output out7;
    output out8;
    output out9;

    wire out_1,out_2,out_3;
    one_to_two_demux_gatelevel_module one_to_two_demux_1(
        .a(a), 
        .s(s[3]), 
        .out1(out_1),
        .out2(out9)
    );    
    one_to_two_demux_gatelevel_module one_to_two_demux_2(
        .a(out_1), 
        .s(s[2]), 
        .out1(out_2),
        .out2(out_3)
    );
    one_to_four_demux_gatelevel_module one_to_four_demux_1(
        .a(out_2), 
        .s0(s[1]), 
        .s1(s[0]),
        .out1(out1),
        .out2(out2), 
        .out3(out3), 
        .out4(out4)
    );
    one_to_four_demux_gatelevel_module one_to_four_demux_2(
        .a(out_3), 
        .s0(s[1]), 
        .s1(s[0]),
        .out1(out5),
        .out2(out6), 
        .out3(out7), 
        .out4(out8)
    );

endmodule
