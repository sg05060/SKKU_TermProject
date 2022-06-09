module eight_bit_xnor_gate(a, b, out);
    input [7:0] a;
    input [7:0] b;
    output [7:0] out;

    xnor_gate xnor_gate_0(.a(a[0]), .b(b[0]), .out(out[0]));
    xnor_gate xnor_gate_1(.a(a[1]), .b(b[1]), .out(out[1]));
    xnor_gate xnor_gate_2(.a(a[2]), .b(b[2]), .out(out[2]));
    xnor_gate xnor_gate_3(.a(a[3]), .b(b[3]), .out(out[3]));
    xnor_gate xnor_gate_4(.a(a[4]), .b(b[4]), .out(out[4]));
    xnor_gate xnor_gate_5(.a(a[5]), .b(b[5]), .out(out[5]));
    xnor_gate xnor_gate_6(.a(a[6]), .b(b[6]), .out(out[6]));
    xnor_gate xnor_gate_7(.a(a[7]), .b(b[7]), .out(out[7]));

endmodule