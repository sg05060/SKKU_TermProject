module Display_module(
    input clk,
    input rst,
    input reg_en,
    input sel,
    input [7:0] c11_sa,
    input [7:0] c12_sa,
    input [7:0] c21_sa,
    input [7:0] c22_sa,
    input [7:0] c11_custom,
    input [7:0] c12_custom,
    input [7:0] c21_custom,
    input [7:0] c22_custom,

    output is_done_o,
    output [3:0] Anode_Activate,
    output [6:0] LED_out
);
    wire [7:0] c11;
    wire [7:0] c12;
    wire [7:0] c21;
    wire [7:0] c22;

    eight_bit_two_to_one_mux_gatelevel_module eight_bit_two_to_one_mux_1(
        .a(c11_sa), 
        .b(c11_custom), 
        .s(sel), 
        .out(c11)
    );
    eight_bit_two_to_one_mux_gatelevel_module eight_bit_two_to_one_mux_2(
        .a(c12_sa), 
        .b(c12_custom), 
        .s(sel), 
        .out(c12)
    );
    eight_bit_two_to_one_mux_gatelevel_module eight_bit_two_to_one_mux_3(
        .a(c21_sa), 
        .b(c21_custom), 
        .s(sel), 
        .out(c21)
    );
    eight_bit_two_to_one_mux_gatelevel_module eight_bit_two_to_one_mux_4(
        .a(c22_sa), 
        .b(c22_custom), 
        .s(sel), 
        .out(c22)
    );
    Seven_segment_LED_Display_Controller Seven_segment_LED_Display_Controller(
    .clock_100Mhz(clk), // 100 Mhz clock source on Basys 3 FPGA
    .reset(rst), // .
    .reg_en(reg_en),
    .c11(c11),
    .c12(c12),
    .c21(c21),
    .c22(c22),

    .is_done_o(is_done_o),
    .Anode_Activate(Anode_Activate), // anode signals of the 7-segment LED display
    .LED_out(LED_out)// cathode patterns of the 7-segment LED display
    );
endmodule