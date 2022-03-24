//This is for the 4:1 mux module.

module four_to_one_mux_gatelevel_module (a, b, c, d, s0, s1, out);
	input a, b, c, d;
	input s0, s1;	
	output out;
	
	wire not_1_output, not_2_output;
	wire and_1_output, and_2_output, and_3_output, and_4_output,
	     and_5_output, and_6_output, and_7_output, and_8_output;
	wire or_1_output, or_2_output;
	
	//Fill this out
	not_gate not_gate_inst_1 (.a(s0), .out(not_1_output));
	not_gate not_gate_inst_2 (.a(s1), .out(not_2_output));
	and_gate and_gate_inst_1 (.a(not_2_output), .b(not_1_output), .out(and_1_output));
	and_gate and_gate_inst_2 (.a(and_1_output), .b(a), .out(and_2_output));
	and_gate and_gate_inst_3 (.a(not_2_output), .b(s0), .out(and_3_output));
	and_gate and_gate_inst_4 (.a(and_3_output), .b(b), .out(and_4_output));
	and_gate and_gate_inst_5 (.a(s1), .b(not_1_output), .out(and_5_output));
	and_gate and_gate_inst_6 (.a(and_5_output), .b(c), .out(and_6_output));
	and_gate and_gate_inst_7 (.a(s0), .b(s1), .out(and_7_output));
	and_gate and_gate_inst_8 (.a(and_7_output), .b(d), .out(and_8_output));
	or_gate or_gate_inst_1 (.a(and_2_output), .b(and_4_output), .out(or_1_output));
	or_gate or_gate_inst_2 (.a(and_6_output), .b(and_8_output), .out(or_2_output));
	or_gate or_gate_inst_3 (.a(or_1_output), .b(or_2_output), .out(out));
	
endmodule
