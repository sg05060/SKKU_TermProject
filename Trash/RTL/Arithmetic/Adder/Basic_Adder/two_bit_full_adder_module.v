//This is for the 4-bit full adder module.

module two_bit_full_adder_module (a, b, cin, sum, cout);
	input [1:0] a, b;
	input cin;
	output [1:0] sum;
	output cout;

	wire cout_1;

	//Fill this out	
    full_adder_gatelevel_module FA_0 (.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(cout_1));
	full_adder_gatelevel_module FA_1 (.a(a[1]), .b(b[1]), .cin(cout_1), .sum(sum[1]), .cout());

endmodule
