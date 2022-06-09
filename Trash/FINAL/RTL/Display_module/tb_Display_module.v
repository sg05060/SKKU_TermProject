module tb_Display_module;
    reg clk;
    reg rst_display_module;
    reg display_mode_reg_en;
    reg [7:0] c11_sa;
    reg [7:0] c12_sa;
    reg [7:0] c21_sa;
    reg [7:0] c22_sa;
    reg [7:0] c11_custom;
    reg [7:0] c12_custom;
    reg [7:0] c21_custom;
    reg [7:0] c22_custom;
    wire display_done;
    wire [3:0] an;
    wire [6:0] seg;

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
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        rst_display_module = 1'b1;
        display_mode_reg_en = 1'b0;
        c11_sa = 8'b0;
        c12_sa = 8'b0;
        c21_sa = 8'b0;
        c22_sa = 8'b0;
        c11_custom = 8'b0;
        c12_custom = 8'b0;
        c21_custom = 8'b0;
        c22_custom = 8'b0;

        #30
            rst_display_module = 1'b0;
        #30
            @(posedge clk);
                #1  display_mode_reg_en = 1'b1;
                    c11_sa = 8'd36;
                    c12_sa = 8'd54;
                    c21_sa = 8'd36;
                    c22_sa = 8'd54;
                    c11_custom = 8'd36;
                    c12_custom = 8'd54;
                    c21_custom = 8'd36;
                    c22_custom = 8'd54;
            wait(display_done == 1'b1);
                @(posedge clk);
                    #1 rst_display_module = 1'b1;
                       display_mode_reg_en = 1'b0;
    end
endmodule