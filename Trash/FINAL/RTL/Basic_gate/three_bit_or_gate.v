module three_bit_or_gate (
    input [2:0] a,
    output wire out
);  
    wire out1;
    or_gate or_gate_1(.a(a[2]), .b(a[1]), .out(out1));
    or_gate or_gate_2(.a(a[0]), .b(out1), .out(out));

endmodule