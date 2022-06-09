module eight_bit_multipiler_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] out
);

    wire [7:0]  mask_output_0, mask_output_1, mask_output_2, mask_output_3, 
                mask_output_4, mask_output_5, mask_output_6, mask_output_7;   
        
    wire [7:0]  sum_0, sum_1, sum_2, sum_3, sum_4, sum_5, sum_6;
    wire        cout_0, cout_1, cout_2, cout_3, cout_4, cout_5, cout_6;

    eight_bitmask eight_bitmask_0 (.a(a), .mask(b[0]), .out(mask_output_0));
    eight_bitmask eight_bitmask_1 (.a(a), .mask(b[1]), .out(mask_output_1));
    eight_bitmask eight_bitmask_2 (.a(a), .mask(b[2]), .out(mask_output_2));
    eight_bitmask eight_bitmask_3 (.a(a), .mask(b[3]), .out(mask_output_3));
    eight_bitmask eight_bitmask_4 (.a(a), .mask(b[4]), .out(mask_output_4));
    eight_bitmask eight_bitmask_5 (.a(a), .mask(b[5]), .out(mask_output_5));
    eight_bitmask eight_bitmask_6 (.a(a), .mask(b[6]), .out(mask_output_6));
    eight_bitmask eight_bitmask_7 (.a(a), .mask(b[7]), .out(mask_output_7));

    eight_bit_full_adder_module eight_bit_full_adder_0(.a({1'b0,mask_output_0[7:1]}), .b(mask_output_1), .cin(1'b0), .sum(sum_0), .cout(cout_0));
    eight_bit_full_adder_module eight_bit_full_adder_1(.a({cout_0,sum_0[7:1]}), .b(mask_output_2), .cin(1'b0), .sum(sum_1), .cout(cout_1));
    eight_bit_full_adder_module eight_bit_full_adder_2(.a({cout_1,sum_1[7:1]}), .b(mask_output_3), .cin(1'b0), .sum(sum_2), .cout(cout_2));
    eight_bit_full_adder_module eight_bit_full_adder_3(.a({cout_2,sum_2[7:1]}), .b(mask_output_4), .cin(1'b0), .sum(sum_3), .cout(cout_3));
    eight_bit_full_adder_module eight_bit_full_adder_4(.a({cout_3,sum_3[7:1]}), .b(mask_output_5), .cin(1'b0), .sum(sum_4), .cout(cout_4));
    eight_bit_full_adder_module eight_bit_full_adder_5(.a({cout_4,sum_4[7:1]}), .b(mask_output_6), .cin(1'b0), .sum(sum_5), .cout(cout_5));
    eight_bit_full_adder_module eight_bit_full_adder_6(.a({cout_5,sum_5[7:1]}), .b(mask_output_7), .cin(1'b0), .sum(sum_6), .cout(cout_6));
    
    assign out = {cout_6,sum_6,sum_5[0],sum_4[0],sum_3[0],sum_2[0],sum_1[0],sum_0[0],mask_output_0[0]};


    /*
    wire and_out_0_0, and_out_0_1, and_out_0_2, and_out_0_3, and_out_0_4, and_out_0_5, and_out_0_6, and_out_0_7,
        and_out_1_0, and_out_1_1, and_out_1_2, and_out_1_3, and_out_1_4, and_out_1_5, and_out_1_6, and_out_1_7,
        and_out_2_0, and_out_2_1, and_out_2_2, and_out_2_3, and_out_2_4, and_out_2_5, and_out_2_6, and_out_2_7,
        and_out_3_0, and_out_3_1, and_out_3_2, and_out_3_3, and_out_3_4, and_out_3_5, and_out_3_6, and_out_3_7,
        and_out_4_0, and_out_4_1, and_out_4_2, and_out_4_3, and_out_4_4, and_out_4_5, and_out_4_6, and_out_4_7,
        and_out_5_0, and_out_5_1, and_out_5_2, and_out_5_3, and_out_5_4, and_out_5_5, and_out_5_6, and_out_5_7,
        and_out_6_0, and_out_6_1, and_out_6_2, and_out_6_3, and_out_6_4, and_out_6_5, and_out_6_6, and_out_6_7,
        and_out_7_0, and_out_7_1, and_out_7_2, and_out_7_3, and_out_7_4, and_out_7_5, and_out_7_6, and_out_7_7; 

    and_gate and_gate_0_0(.a(a[0]), .b(b[0]), .out(and_out_0_0));
    and_gate and_gate_0_1(.a(a[1]), .b(b[0]), .out(and_out_0_1));
    and_gate and_gate_0_2(.a(a[2]), .b(b[0]), .out(and_out_0_2));
    and_gate and_gate_0_3(.a(a[3]), .b(b[0]), .out(and_out_0_3));
    and_gate and_gate_0_4(.a(a[4]), .b(b[0]), .out(and_out_0_4));
    and_gate and_gate_0_5(.a(a[5]), .b(b[0]), .out(and_out_0_5));
    and_gate and_gate_0_6(.a(a[6]), .b(b[0]), .out(and_out_0_6));
    and_gate and_gate_0_7(.a(a[7]), .b(b[0]), .out(and_out_0_7));

    and_gate and_gate_1_0(.a(a[0]), .b(b[1]), .out(and_out_1_0));
    and_gate and_gate_1_1(.a(a[1]), .b(b[1]), .out(and_out_1_1));
    and_gate and_gate_1_2(.a(a[2]), .b(b[1]), .out(and_out_1_2));
    and_gate and_gate_1_3(.a(a[3]), .b(b[1]), .out(and_out_1_3));
    and_gate and_gate_1_4(.a(a[4]), .b(b[1]), .out(and_out_1_4));
    and_gate and_gate_1_5(.a(a[5]), .b(b[1]), .out(and_out_1_5));
    and_gate and_gate_1_6(.a(a[6]), .b(b[1]), .out(and_out_1_6));
    and_gate and_gate_1_7(.a(a[7]), .b(b[1]), .out(and_out_1_7));

    and_gate and_gate_2_0(.a(a[0]), .b(b[2]), .out(and_out_2_0));
    and_gate and_gate_2_1(.a(a[1]), .b(b[2]), .out(and_out_2_1));
    and_gate and_gate_2_2(.a(a[2]), .b(b[2]), .out(and_out_2_2));
    and_gate and_gate_2_3(.a(a[3]), .b(b[2]), .out(and_out_2_3));
    and_gate and_gate_2_4(.a(a[4]), .b(b[2]), .out(and_out_2_4));
    and_gate and_gate_2_5(.a(a[5]), .b(b[2]), .out(and_out_2_5));
    and_gate and_gate_2_6(.a(a[6]), .b(b[2]), .out(and_out_2_6));
    and_gate and_gate_2_7(.a(a[7]), .b(b[2]), .out(and_out_2_7));

    and_gate and_gate_3_0(.a(a[0]), .b(b[3]), .out(and_out_3_0));
    and_gate and_gate_3_1(.a(a[1]), .b(b[3]), .out(and_out_3_1));
    and_gate and_gate_3_2(.a(a[2]), .b(b[3]), .out(and_out_3_2));
    and_gate and_gate_3_3(.a(a[3]), .b(b[3]), .out(and_out_3_3));
    and_gate and_gate_3_4(.a(a[4]), .b(b[3]), .out(and_out_3_4));
    and_gate and_gate_3_5(.a(a[5]), .b(b[3]), .out(and_out_3_5));
    and_gate and_gate_3_6(.a(a[6]), .b(b[3]), .out(and_out_3_6));
    and_gate and_gate_3_7(.a(a[7]), .b(b[3]), .out(and_out_3_7));

    and_gate and_gate_4_0(.a(a[0]), .b(b[4]), .out(and_out_4_0));
    and_gate and_gate_4_1(.a(a[1]), .b(b[4]), .out(and_out_4_1));
    and_gate and_gate_4_2(.a(a[2]), .b(b[4]), .out(and_out_4_2));
    and_gate and_gate_4_3(.a(a[3]), .b(b[4]), .out(and_out_4_3));
    and_gate and_gate_4_4(.a(a[4]), .b(b[4]), .out(and_out_4_4));
    and_gate and_gate_4_5(.a(a[5]), .b(b[4]), .out(and_out_4_5));
    and_gate and_gate_4_6(.a(a[6]), .b(b[4]), .out(and_out_4_6));
    and_gate and_gate_4_7(.a(a[7]), .b(b[4]), .out(and_out_4_7));

    and_gate and_gate_5_0(.a(a[0]), .b(b[5]), .out(and_out_5_0));
    and_gate and_gate_5_1(.a(a[1]), .b(b[5]), .out(and_out_5_1));
    and_gate and_gate_5_2(.a(a[2]), .b(b[5]), .out(and_out_5_2));
    and_gate and_gate_5_3(.a(a[3]), .b(b[5]), .out(and_out_5_3));
    and_gate and_gate_5_4(.a(a[4]), .b(b[5]), .out(and_out_5_4));
    and_gate and_gate_5_5(.a(a[5]), .b(b[5]), .out(and_out_5_5));
    and_gate and_gate_5_6(.a(a[6]), .b(b[5]), .out(and_out_5_6));
    and_gate and_gate_5_7(.a(a[7]), .b(b[5]), .out(and_out_5_7));

    and_gate and_gate_6_0(.a(a[0]), .b(b[6]), .out(and_out_6_0));
    and_gate and_gate_6_1(.a(a[1]), .b(b[6]), .out(and_out_6_1));
    and_gate and_gate_6_2(.a(a[2]), .b(b[6]), .out(and_out_6_2));
    and_gate and_gate_6_3(.a(a[3]), .b(b[6]), .out(and_out_6_3));
    and_gate and_gate_6_4(.a(a[4]), .b(b[6]), .out(and_out_6_4));
    and_gate and_gate_6_5(.a(a[5]), .b(b[6]), .out(and_out_6_5));
    and_gate and_gate_6_6(.a(a[6]), .b(b[6]), .out(and_out_6_6));
    and_gate and_gate_6_7(.a(a[7]), .b(b[6]), .out(and_out_6_7));

    and_gate and_gate_7_0(.a(a[0]), .b(b[7]), .out(and_out_7_0));
    and_gate and_gate_7_1(.a(a[1]), .b(b[7]), .out(and_out_7_1));
    and_gate and_gate_7_2(.a(a[2]), .b(b[7]), .out(and_out_7_2));
    and_gate and_gate_7_3(.a(a[3]), .b(b[7]), .out(and_out_7_3));
    and_gate and_gate_7_4(.a(a[4]), .b(b[7]), .out(and_out_7_4));
    and_gate and_gate_7_5(.a(a[5]), .b(b[7]), .out(and_out_7_5));
    and_gate and_gate_7_6(.a(a[6]), .b(b[7]), .out(and_out_7_6));
    and_gate and_gate_7_7(.a(a[7]), .b(b[7]), .out(and_out_7_7));
    */
endmodule