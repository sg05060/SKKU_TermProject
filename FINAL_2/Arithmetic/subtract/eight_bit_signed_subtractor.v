module eigth_bit_signed_subtractor(
    input [7:0] a,
    input [7:0] b,
    output [7:0] out
);
    wire cout;
    four_bit_signed_subtractor inst_1(
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(1'b1),
        .out(out[3:0]),
        .cout(cout)
    );  
    four_bit_signed_subtractor inst_2(
        .a(a[7:4]),
        .b(b[7:4]),
        .cin(cout),
        .out(out[7:4]),
        .cout()
    );  
endmodule
