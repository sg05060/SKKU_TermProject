
module eight_bit_full_adder_module (a, b, cin, sum, cout);
	input [7:0] a, b;
	input cin;
	output [7:0] sum;
	output cout;

	wire cout_mid;

	//Fill this out	
    four_bit_full_adder_module FA4_0 (.a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .cout(cout_mid));
    four_bit_full_adder_module FA4_1 (.a(a[7:4]), .b(b[7:4]), .cin(cout_mid), .sum(sum[7:4]), .cout(cout));
endmodule
