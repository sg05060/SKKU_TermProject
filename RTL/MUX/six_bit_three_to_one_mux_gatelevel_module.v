module six_bit_three_to_one_mux_gatelevel_module(a,b,c,s,out);
    input [5:0] a;
    input [5:0] b;
    input [5:0] c;
    input [1:0] s;
    output [5:0] out;

    three_to_one_mux_gatelevel_module three_to_one_mux_gatelevel_module_inst_0 (.a(a[0]), .b(b[0]), .c(c[0]), .s0(s[0]), .s1(s[1]), .out(out[0]));
    three_to_one_mux_gatelevel_module three_to_one_mux_gatelevel_module_inst_1 (.a(a[1]), .b(b[1]), .c(c[1]), .s0(s[0]), .s1(s[1]), .out(out[1]));
    three_to_one_mux_gatelevel_module three_to_one_mux_gatelevel_module_inst_2 (.a(a[2]), .b(b[2]), .c(c[2]), .s0(s[0]), .s1(s[1]), .out(out[2]));
    three_to_one_mux_gatelevel_module three_to_one_mux_gatelevel_module_inst_3 (.a(a[3]), .b(b[3]), .c(c[3]), .s0(s[0]), .s1(s[1]), .out(out[3]));
    three_to_one_mux_gatelevel_module three_to_one_mux_gatelevel_module_inst_4 (.a(a[4]), .b(b[4]), .c(c[4]), .s0(s[0]), .s1(s[1]), .out(out[4]));
    three_to_one_mux_gatelevel_module three_to_one_mux_gatelevel_module_inst_5 (.a(a[5]), .b(b[5]), .c(c[5]), .s0(s[0]), .s1(s[1]), .out(out[5]));

endmodule