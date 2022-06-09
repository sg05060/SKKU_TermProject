module three_to_one_mux_gatelevel_module (
    input a,
    input b,
    input c,
    input s0,
    input s1,
    output wire out
);

four_to_one_mux_gatelevel_module four_to_one_mux_inst_0(
    .a(a),
    .b(b),
    .c(c),
    .d(c),
    .s0(s0),
    .s1(s1),
    .out(out)
);

endmodule