module tb_top_module;
    reg clk;
    reg rst;
    reg start;
    wire [3:0] Anode_Activate;
    wire [6:0] LED_out;
    top_module top_module(
    .clk(clk),
    .rst(rst),
    .start(start),
    .Anode_Activate(Anode_Activate),
    .LED_out(LED_out)
    );
    always #5 clk = ~clk;
    initial begin
        clk = 0; rst = 1; start = 0;
        #30 rst = 0;
        #10 start = 1'b1;
    end

endmodule  