// registering feature and weight value, multiply data
module Custom_Buff_ALU(
    
    input   clk,
    input   rst,
    input   feature_en,
    input   weight_en,
    
    input   [7:0]   data_in,
    output  [7:0]   mul_out
);

    wire    [7:0]   feature_w;
    wire    [7:0]   weight_w;

    eight_bit_en_register feature_buff(
        .in     (data_in), 
        .clk    (clk), 
        .en     (feature_en), 
        .rst    (rst), 
        .out    (feature_w)
    );

    eight_bit_en_register weight_buff(
        .in     (data_in), 
        .clk    (clk), 
        .en     (weight_en), 
        .rst    (rst), 
        .out    (weight_w)
    );

    eight_bit_multipiler_module eight_bit_multipiler_inst(
        .a      (feature_w),
        .b      (weight_w),
        .out    (mul_out)
    );

endmodule