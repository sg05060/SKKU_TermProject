module tb_Serial_mode;
    reg clk;
    reg rst;
    reg en;
    reg [7:0] feature_baseaddr;
    wire is_done_o;
    wire [7:0] out;

    always #5 clk = ~clk;
    initial begin
        clk = 0;
        rst = 1;
        en = 0;
        feature_baseaddr = 8'b0000_1001;

        #100
            rst = 0;
        @(posedge clk);
            #1 en = 1;
        wait(is_done_o);
            @(posedge clk);
             #1 feature_baseaddr = 8'b0000_1010;
        wait(is_done_o);
            @(posedge clk);
             #1 feature_baseaddr = 8'b0000_1101;
        wait(is_done_o);
            @(posedge clk);
             #1 feature_baseaddr = 8'b0000_1110;
        wait(is_done_o);
            repeat(2) @(posedge clk);
                            #1 rst = 1'b1;
    end
    top_serial_mode top(
        .clk(clk),
        .rst(rst),
        .en(en),
        .feature_baseaddr(feature_baseaddr),
        .is_done_o(is_done_o),
        .out(out)
    );
endmodule