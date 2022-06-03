module tb_Top_custom_mode;
    reg clk;
    reg rst;
    reg custom_mode_en;
    wire custom_mode_done;
    wire [7:0] c11_custom;
    wire [7:0] c12_custom;
    wire [7:0] c21_custom;
    wire [7:0] c22_custom;

    Top_Custom_mode Top_Custom_mode(
        .clk(clk),
        .rst(rst),
        .custom_mode_en(custom_mode_en),
        .custom_mode_done(custom_mode_done),
        .c11_custom(c11_custom),
        .c12_custom(c12_custom),
        .c21_custom(c21_custom),
        .c22_custom(c22_custom)
    );
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        rst = 1'b1;
        custom_mode_en = 1'b0;

        #30
            rst = 1'b0;
            custom_mode_en = 1'b1;
            
        wait(custom_mode_done == 1'b1);
            @(posedge clk);
                #1 rst = 1'b1;
    end
endmodule