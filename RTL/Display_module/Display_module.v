module Display_module(
    input clk,
    input rst,
    input reg_en,
    input [7:0] c11,
    input [7:0] c12,
    input [7:0] c21,
    input [7:0] c22,

    output is_done_o,
    output [3:0] Anode_Activate,
    output [6:0] LED_out
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