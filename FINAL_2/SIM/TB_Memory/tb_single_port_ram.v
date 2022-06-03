module tb_single_port_ram;
    reg     [7:0]   data;
    reg     [5:0]   addr;
    reg             we;
    reg             clk;
    wire    [7:0]   q;
    
    
    // DUT inst
    single_port_ram DUT(
        .data   (data),
        .addr   (addr),
        .we     (we),
        .clk    (clk),
        .q      (q)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        #0  // idle
            clk     = 0;
            we      = 1'b0;
            addr    = 6'b00_0000;
            data    = 8'b0;
        
        // write
        
        #10 // write num 0 in addr = 6'b00_0000
            we      = 1'b1;
            addr    = 6'b00_0000;
            data    = 8'd0;
        #10 // write num 1 in addr = 6'b00_0001
            addr    = 6'b00_0001;
            data    = 8'd1;
        #10 // write num 2 in addr = 6'b00_0010
            addr    = 6'b00_0010;
            data    = 8'd2;
        #10 // write num 3 in addr = 6'b00_0011
            addr    = 6'b00_0011;
            data    = 8'd3;
        #10 // write num 4 in addr = 6'b00_0100
            addr    = 6'b00_0100;
            data    = 8'd4;
            
        // read
        
        #10 // read addr = 6'b00_0000
            we      = 1'b0;
            addr    = 6'b00_0000;
        #10 // read addr = 6'b00_0001
            addr    = 6'b00_0001;
        #10 // read addr = 6'b00_0010
            addr    = 6'b00_0010;
        #10 // read addr = 6'b00_0011
            addr    = 6'b00_0011;
        #10 // read addr = 6'b00_0100
            addr    = 6'b00_0100;
    end
    
endmodule