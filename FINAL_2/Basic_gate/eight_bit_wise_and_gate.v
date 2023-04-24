module eight_bit_wise_and_gate(a,out);
    input [7:0] a;
    output out;

    wire and_out_1;
    wire and_out_2;
    wire and_out_3;
    wire and_out_4;
    wire and_out_5;
    wire and_out_6;

    and_gate and_gate_1(.a(a[0]), .b(a[1]), .out(and_out_1));
    and_gate and_gate_2(.a(and_out_1), .b(a[2]), .out(and_out_2));
    and_gate and_gate_3(.a(and_out_2), .b(a[3]), .out(and_out_3));
    and_gate and_gate_4(.a(and_out_3), .b(a[4]), .out(and_out_4));
    and_gate and_gate_5(.a(and_out_4), .b(a[5]), .out(and_out_5));
    and_gate and_gate_6(.a(and_out_5), .b(a[6]), .out(and_out_6));
    and_gate and_gate_7(.a(and_out_6), .b(a[7]), .out(out));


endmodule