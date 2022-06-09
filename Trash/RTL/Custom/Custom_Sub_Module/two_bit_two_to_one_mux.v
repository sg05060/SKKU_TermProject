module two_bit_two_to_one_mux(
    input   [1:0]   a,
    input   [1:0]   b,
    input           s,
    output  [1:0]   out
);

    two_to_one_mux_gatelevel_module two_to_one_mux1_inst(.a(a[0]), .b(b[0]), .s(s), .out(out[0]));
    two_to_one_mux_gatelevel_module two_to_one_mux2_inst(.a(a[1]), .b(b[1]), .s(s), .out(out[1]));

endmodule