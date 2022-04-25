module Custom_Ring_Counter_gju06_tb;
    
    localparam CLOCK_DELAY  = 10;
    localparam TEST_CNT_VAL = 30;
    
    
    reg             clk;
    reg             rst;
    reg             en;
    reg     [7:0]   i_num_cnt;
    wire    [7:0]   cnt_o;
    wire            done_o;
    
    // instanciate device under test
    Custom_Ring_Counter_gju06 custom_ring_couter_inst(
        .clk        (clk), 
        .rst        (rst), 
        .en         (en),
        .i_num_cnt  (i_num_cnt),
        .cnt_o      (cnt_o),
        .done_o     (done_o)
    );
    
    // generating clock signal
    initial begin
        clk                         = 1'b0; // clock initialize
        forever begin
            #(CLOCK_DELAY/2) clk    = ~clk; // clock vibration
        end
    end
    
    // generating reset signal
    initial begin
        rst                         = 1'b1; // reset initialize(positive reset -> initialize 1 for reset all signal)
        #15
        rst                         = 1'b0; // release the reset
    end
    
    // testbench
    initial begin
        wait (rst==0);      // wait for reset release
        @(posedge clk);     // wait for clock rising
        
        #3  i_num_cnt   = TEST_CNT_VAL;
            en          = 1;
        
        wait (done_o==1);               // wait for counter actiavation is done
        repeat (2) @(posedge clk);      // wait for clock signal twice
        en  = 0;                        // stop counter actiavation 
        #(CLOCK_DELAY * 2)
        $stop;
    end
    
    
endmodule