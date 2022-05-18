module Custom_tb;
    reg             clk;
    reg             rst;
    reg             en;
    reg             we;
    reg     [7:0]   data_write;
    
    wire            is_done_o;
    wire    [7:0]   c11;
    wire    [7:0]   c12;
    wire    [7:0]   c21;
    wire    [7:0]   c22;
    

    localparam CLOCK_DELAY  = 10;


    // inst
    Custom_mode_conntect_Memory DUT(
        .clk        (clk),
        .rst        (rst),
        .en         (en),
        .we         (we),
        .data_write (data_write),
        
        .is_done_o  (is_done_o),
        .c11        (c11),
        .c12        (c12),
        .c21        (c21),
        .c22        (c22)
    );

    // generating clock signal
    initial begin
        clk                         = 1'b0; // clock initialize
        forever begin
            #(CLOCK_DELAY/2) clk    = ~clk; // clock vibration
        end
    end

    initial begin
        rst                         = 1'b1; // reset initialize(positive reset -> initialize 1 for reset all signal)
        #15
        rst                         = 1'b0; // release the reset
    end
    

    initial begin
        en                          = 1'b0;
        data_write                  = 8'b0;
        we                          = 1'b0;
    end
    
    initial begin
        // test plan1
        wait (rst==0);      // wait for reset release
        @(posedge clk);     // wait for clock rising
        
        en                          = 1;
        
        wait (is_done_o==1'b1);     // wait for counter actiavation is done
        @(posedge clk);             // wait for clock signal twice
        @(posedge clk);
        @(posedge clk);        
        #3
        en                          = 0;        // stop counter actiavation 
        #(CLOCK_DELAY * 2)
        
        $stop;
    end
    
endmodule