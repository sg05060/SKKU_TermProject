module four_bit_or_gate (
    input [3:0] a,
    output wire out
);  
    wire out1, out2, out3;
    
    or_gate or_gate_1(.a(a[3]), .b(a[2]), .out(out1));
    or_gate or_gate_2(.a(a[1]), .b(a[0]), .out(out2));
    or_gate or_gate_3(.a(out1), .b(out2), .out(out));
endmodule