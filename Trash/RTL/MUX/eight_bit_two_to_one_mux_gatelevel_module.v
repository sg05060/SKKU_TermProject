module eight_bit_two_to_one_mux_gatelevel_module(a, b, s, out);
    input [7:0] a;
    input [7:0] b;
    input s;
    output [7:0] out;

    two_to_one_mux_gatelevel_module two_to_one_mux_gatelevel_module_inst_0(.a(a[0]), .b(b[0]), .s(s), .out(out[0]));
    two_to_one_mux_gatelevel_module two_to_one_mux_gatelevel_module_inst_1(.a(a[1]), .b(b[1]), .s(s), .out(out[1]));
    two_to_one_mux_gatelevel_module two_to_one_mux_gatelevel_module_inst_2(.a(a[2]), .b(b[2]), .s(s), .out(out[2]));
    two_to_one_mux_gatelevel_module two_to_one_mux_gatelevel_module_inst_3(.a(a[3]), .b(b[3]), .s(s), .out(out[3]));
    two_to_one_mux_gatelevel_module two_to_one_mux_gatelevel_module_inst_4(.a(a[4]), .b(b[4]), .s(s), .out(out[4]));
    two_to_one_mux_gatelevel_module two_to_one_mux_gatelevel_module_inst_5(.a(a[5]), .b(b[5]), .s(s), .out(out[5]));
    two_to_one_mux_gatelevel_module two_to_one_mux_gatelevel_module_inst_6(.a(a[6]), .b(b[6]), .s(s), .out(out[6]));
    two_to_one_mux_gatelevel_module two_to_one_mux_gatelevel_module_inst_7(.a(a[7]), .b(b[7]), .s(s), .out(out[7]));
endmodule