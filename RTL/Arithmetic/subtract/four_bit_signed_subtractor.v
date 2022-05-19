module four_bit_signed_subtractor(
    input   [3:0] a,
    input   [3:0] b,
    input   cin,
    output  [3:0] out,
    output  wire cout
);  
    wire not_1,not_2,not_3,not_4;
    wire b_1,b_2,b_3,b_4;
    wire cout_1,cout_2,cout_3;
    xnor_gate xnor_gate_1(.a(b[0]), .b(1'b1), .out(not_1));
    not_gate not_gate_1(.a(not_1), .out(b_1));
    xnor_gate xnor_gate_2(.a(b[1]), .b(1'b1), .out(not_2));
    not_gate not_gate_2(.a(not_2), .out(b_2)); 
    xnor_gate xnor_gate_3(.a(b[2]), .b(1'b1), .out(not_3));
    not_gate not_gate_3(.a(not_3), .out(b_3)); 
    xnor_gate xnor_gate_4(.a(b[3]), .b(1'b1), .out(not_4));
    not_gate not_gate_4(.a(not_4), .out(b_4)); 
    full_adder_gatelevel_module FA_0 (.a(a[0]), .b(b_1), .cin(cin), .sum(out[0]), .cout(cout_1));
	full_adder_gatelevel_module FA_1 (.a(a[1]), .b(b_2), .cin(cout_1), .sum(out[1]), .cout(cout_2));
	full_adder_gatelevel_module FA_2 (.a(a[2]), .b(b_3), .cin(cout_2), .sum(out[2]), .cout(cout_3));
	full_adder_gatelevel_module FA_3 (.a(a[3]), .b(b_4), .cin(cout_3), .sum(out[3]), .cout(cout));
endmodule