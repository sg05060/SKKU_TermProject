module eight_bit_adder_modify_module (a, b, sum, cout);
	input [7:0] a, b;
	output [7:0] sum;
	output cout;

	wire cout_mid;

	//Fill this out	
    four_bit_adder_modify_module FA4_M_0 (.a(a[3:0]), .b(b[3:0]), .sum(sum[3:0]), .cout(cout_mid));
    four_bit_full_adder_module FA4_1 (.a(a[7:4]), .b(b[7:4]), .cin(cout_mid), .sum(sum[7:4]), .cout(cout));
    
endmodule
