module tb_Display_module;
    reg clk,
    reg 
Display_module display_module(
        .clock_100Mhz(clk),
        .reset(rst_display_module),
        .reg_en(display_mode_reg_en),
        .c11_sa(c11_sa),
        .c12_sa(c12_sa),
        .c21_sa(c21_sa),
        .c22_sa(c22_sa),
        .c11_custom(c11_custom),
        .c12_custom(c12_custom),
        .c21_custom(c21_custom),
        .c22_custom(c22_custom),

        .is_done_o(display_done),
        .Anode_Activate(an),
        .LED_out(seg)
    );