module half_adder_gatelevel_module (a, b, sum, cout);
	input a, b;
	output sum, cout;
	wire xnor_out;
	
	// sum
	xnor_gate xnor_1(.a(a), .b(b), .out(xnor_out));
	not_gate not_1(.a(xnor_out), .out(sum));

	// carry
	and_gate and_1(.a(a), .b(b), .out(cout));
	
endmodule