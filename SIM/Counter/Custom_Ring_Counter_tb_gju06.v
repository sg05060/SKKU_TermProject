module tb_custom_ring_counter;
    reg             clk;
    reg             rst;
    reg             en;
    wire    [7:0]   i_num_cnt;
    wire    [7:0]   cnt_o;
    wire            done_o;
    
    // making clock signal
    initial begin
        always #5 clk = ~clk;
    end
    
    // 
    initial begin
        #0  clk = 0; 
            rst = 1; 
            en  = 0; 
            i_num_cnt = 8'b0;
        
        #50 rst = 0;
        
        #10 en  = 1; 
            i_num_cnt = 8'd30;
        #1000;
    end
    
    Custom_Ring_Counter_gju06 custom_ring_couter_inst(
        .clk        (clk), 
        .rst        (rst), 
        .en         (en),
        .i_num_cnt  (i_num_cnt),
        .cnt_o      (cnt_o),
        .done_o     (done_o)
    );
    
endmodule