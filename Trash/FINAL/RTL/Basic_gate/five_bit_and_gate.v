module five_bit_and_gate (
    input [4:0] a,
    output wire out
);  
    wire out1, out2, out3;
    
    and_gate and_gate_1(.a(a[4]), .b(a[3]), .out(out1));
    and_gate and_gate_2(.a(a[2]), .b(a[1]), .out(out2));
    and_gate and_gate_3(.a(a[0]), .b(out1), .out(out3));
    and_gate and_gate_4(.a(out2), .b(out3), .out(out));
    
endmodule