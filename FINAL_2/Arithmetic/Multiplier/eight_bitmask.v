module eight_bitmask (  // sg
    input       [7:0]   a,
    input               mask,
    output wire [7:0]   out
);
    and_gate and_gate_0(.a(a[0]), .b(mask), .out(out[0]));
    and_gate and_gate_1(.a(a[1]), .b(mask), .out(out[1]));
    and_gate and_gate_2(.a(a[2]), .b(mask), .out(out[2]));
    and_gate and_gate_3(.a(a[3]), .b(mask), .out(out[3]));
    and_gate and_gate_4(.a(a[4]), .b(mask), .out(out[4]));
    and_gate and_gate_5(.a(a[5]), .b(mask), .out(out[5]));
    and_gate and_gate_6(.a(a[6]), .b(mask), .out(out[6]));
    and_gate and_gate_7(.a(a[7]), .b(mask), .out(out[7]));

endmodule
