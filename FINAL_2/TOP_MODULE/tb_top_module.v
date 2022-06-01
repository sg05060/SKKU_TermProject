module tb_top_module;
    reg clk;
    reg [1:0] sw;
    wire [3:0] an;
    wire [6:0] seg;
    top_module top_module(
    .clk(clk),
    .sw(sw),
    .an(an),
    .seg(seg)
    );
    always #5 clk = ~clk;
    initial begin
        clk = 0; sw[0] = 0; sw[1] = 0;
        #30 sw[0] = 1;
        #10 sw[1] = 1'b1;
    end

endmodule  