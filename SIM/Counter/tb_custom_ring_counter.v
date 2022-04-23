module tb_custom_ring_counter;
    reg clk;
    reg rst;
    reg en;
    reg [7:0] i_num_cnt;
    wire [7:0] out;
    wire is_done_o;

    always #5 clk = ~clk;
    initial begin
        #0 clk = 0; rst = 1; en = 0; i_num_cnt = 8'b0;
        #50 rst = 0;
        #10 en = 1; i_num_cnt = 8'b0000_1010;
        #1000;


    end
    custom_ring_couter custom_ring_couter_inst(
        .clk(clk), 
        .rst(rst), 
        .en(en),
        .i_num_cnt(i_num_cnt),
        .out(out),
        .is_done_o(is_done_o)
    );
endmodule