module Custom_Ring_Counter_gju06 
(
    input               clk,
    input               rst,
    input               en,
    input [7:0]         cnt_i,
    
    output wire [7:0]   cnt_o,
    output wire         done_o
);




    eight_bit_register_behavioral_module ff_8(.in(), .clk(), .rst(), .out());
    two_to_one_mux_gatelevel_module mux_2_to_1_A(.a(), .b(), .s(), .out());

endmodule