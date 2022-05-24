module three_bit_and_gate (
    input [2:0] a,
    output wire out
);  
    wire out1;
    and_gate and_gate_1(.a(a[2]), .b(a[1]), .out(out1));
    and_gate and_gate_2(.a(a[0]), .b(out1), .out(out));
   
endmodule