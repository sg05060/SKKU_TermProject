
module four_bit_adder_modify_module (a, b, sum, cout);
	input [3:0] a, b;
	output [3:0] sum;
	output cout;

	wire cout_1, cout_2, cout_3;

	//Fill this out	
    half_adder_gatelevel_module HA_0 (.a(a[0]), .b(b[0]), .sum(sum[0]), .cout(cout_1));
	full_adder_gatelevel_module FA_1 (.a(a[1]), .b(b[1]), .cin(cout_1), .sum(sum[1]), .cout(cout_2));
	full_adder_gatelevel_module FA_2 (.a(a[2]), .b(b[2]), .cin(cout_2), .sum(sum[2]), .cout(cout_3));
	full_adder_gatelevel_module FA_3 (.a(a[3]), .b(b[3]), .cin(cout_3), .sum(sum[3]), .cout(cout));

endmodule
