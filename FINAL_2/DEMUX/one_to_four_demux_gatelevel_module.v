//This is for the 1:4 demux module.

module one_to_four_demux_gatelevel_module (a, s0, s1, out1, out2, out3, out4);
	input a;
	input s0, s1;	
	output out1, out2, out3, out4;

	wire not_1_output, not_2_output;
	wire and_1_output, and_3_output, and_5_output, and_7_output;

	//Fill this out.
	not_gate not_gate_inst_1 (.a(s0), .out(not_1_output));
	not_gate not_gate_inst_2 (.a(s1), .out(not_2_output));
	and_gate and_gate_inst_1 (.a(not_2_output), .b(not_1_output), .out(and_1_output));
	and_gate and_gate_inst_2 (.a(and_1_output), .b(a), .out(out1));
	and_gate and_gate_inst_3 (.a(not_2_output), .b(s0), .out(and_3_output));
	and_gate and_gate_inst_4 (.a(and_3_output), .b(a), .out(out2));
	and_gate and_gate_inst_5 (.a(s1), .b(not_1_output), .out(and_5_output));
	and_gate and_gate_inst_6 (.a(and_5_output), .b(a), .out(out3));
	and_gate and_gate_inst_7 (.a(s1), .b(s0), .out(and_7_output));
	and_gate and_gate_inst_8 (.a(and_7_output), .b(a), .out(out4));
	
endmodule
