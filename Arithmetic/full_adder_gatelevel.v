//This is for the 1-bit full adder module.

module full_adder_gatelevel_module (a, b, cin, sum, cout);
	input a, b, cin;
	output sum, cout;

	wire xnor_out_1, xnor_out_2;
	wire not_out_1;

	wire and_out_1, and_out_2, and_out_3;
	wire or_out_1;

	//sum
	//Fill this out
	xnor_gatelevel_gate xnor_gate_inst_1 (.a(a), .b(b), .out(xnor_out_1) );
	not_gate not_gate_inst_1(.a(xnor_out_1), .out(not_out_1) );
	xnor_gatelevel_gate xnor_gate_inst_2(.a(not_out_1), .b(cin), .out(xnor_out_2));
	not_gate not_gate_inst_2(.a(xnor_out_2), .out(sum));

	//cout
	//Fill this out
	and_gate and_gate_inst_1 	(.a(a), .b(b), .out(and_out_1));
	and_gate and_gate_inst_2 	(.a(b), .b(cin), .out(and_out_2));
	and_gate and_gate_inst_3 	(.a(cin), .b(a), .out(and_out_3));
	or_gate or_gate_inst_1		(.a(and_out_1), .b(and_out_2), .out(or_out_1));
	or_gate or_gate_inst_2		(.a(or_out_1), .b(and_out_3), .out(cout));
	
endmodule