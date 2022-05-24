module four_bit_and_gate (
    input [3:0] a,
    output out
);  
    wire out1,out2;
    and_gate and_gate_1(.a(a[3]), .b(a[2]), .out(out1));
    and_gate and_gate_2(.a(a[1]), .b(out1), .out(out2));
    and_gate and_gate_3(.a(a[0]), .b(out2), .out(out));
endmodule