module custom_acc(
    input   [7:0]   in_1,
    input   [7:0]   in_2,
    input   [7:0]   in_3,
    input   [7:0]   in_4,
    
    input           clk,
    input           rst,
    input           en,

    output  [7:0]   out 
);

    wire    [7:0]   sum_stage1_out1;
    wire    [7:0]   sum_stage1_out2;
    wire    [7:0]   sum_stage2_out;
    
    
    // stage1
    eight_bit_full_adder_module eight_bit_full_adder_module_stage1_1(
        .a      (in_1), 
        .b      (in_2), 
        .cin    (1'b0), 
        .sum    (sum_stage1_out1), 
        .cout   ()
    );
    eight_bit_full_adder_module eight_bit_full_adder_module_stage1_2(
        .a      (in_3), 
        .b      (in_4), 
        .cin    (1'b0), 
        .sum    (sum_stage1_out2), 
        .cout   ()
    );
    
    // stage2
    eight_bit_full_adder_module eight_bit_full_adder_module_stage2(
        .a      (sum_stage1_out1), 
        .b      (sum_stage1_out2), 
        .cin    (1'b0), 
        .sum    (sum_stage2_out), 
        .cout   ()
    );
    
    // accumulator
    eight_bit_accumulator eight_bit_accumulator_inst(
        .in     (sum_stage2_out), 
        .clk    (clk), 
        .en     (en), 
        .rst    (rst), 
        .out    (out)
    );
    
endmodule
