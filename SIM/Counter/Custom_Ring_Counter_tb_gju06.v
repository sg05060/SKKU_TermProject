module Custom_Ring_Counter_gju06_tb;
    reg             clk;
    reg             rst;
    reg             en;
    reg     [7:0]   i_num_cnt;
    wire    [7:0]   cnt_o;
    wire            done_o;
    
    // making clock signal
    initial begin
        clk = 1'b0;
        forever
            #5 clk = ~clk;
    end
    
    // 
    initial begin
        #0  clk = 0; 
            rst = 1; 
            en  = 0; 
            i_num_cnt = 8'b0;
        
        #50 rst = 0;
        #20 i_num_cnt = 8'd30;
        #10 en  = 1; 
            wait (done_o==1);
            @(posedge clk);
            en  = 0;
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