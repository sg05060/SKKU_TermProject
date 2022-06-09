module four_bit_one_to_two_demux_module(

    input   [3:0]   a,
    input           s,
    output  [3:0]   out1,
    output  [3:0]   out2
);

    one_to_two_demux_gatelevel_module one_to_two_demux_gatelevel_module_1(
        .a      (a[0]), 
        .s      (s), 
        .out1   (out1[0]), 
        .out2   (out2[0])
    );
    one_to_two_demux_gatelevel_module one_to_two_demux_gatelevel_module_2(
        .a      (a[1]), 
        .s      (s), 
        .out1   (out1[1]), 
        .out2   (out2[1])
    );
    one_to_two_demux_gatelevel_module one_to_two_demux_gatelevel_module_3(
        .a      (a[2]), 
        .s      (s), 
        .out1   (out1[2]), 
        .out2   (out2[2])
    );
    one_to_two_demux_gatelevel_module one_to_two_demux_gatelevel_module_4(
        .a      (a[3]), 
        .s      (s), 
        .out1   (out1[3]), 
        .out2   (out2[3])
    );
        
endmodule