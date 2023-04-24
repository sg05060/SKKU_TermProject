module tb_Controller;
    reg clk;
    reg rst;
    reg start;  // start overall flow(initialize memory -> serial -> systolic -> custom -> display)
    
    // done signal
    reg serial_mode_done;
    reg weight_Preloader_done;
    reg feature_Loader_done;
    reg custom_mode_done;
    reg display_done;

    // rst signal
    wire rst_computation_module;
    wire rst_display_module;
    
    // data & addr 
    wire [7:0] data;
    wire [5:0] addr_0;

    // mem selct signal(controller || computation)
    wire mem_sel;
    
    // base address(refer serial&systolic data_loader report)
    wire [7:0] serial_mode_feature_baseaddr;
    wire [5:0] systolic_mode_feature_baseaddr;
    
    // enable select signal
    wire serial_mode_en;
    wire Weight_Preloader_en;
    wire Feature_Loader_en;
    wire custom_mode_en;
    wire systolic_mode;   // weight perload or feature load
    wire [1:0] c_reg_sel; // select c11 or c12 or c21 or c22 to store result
    wire [1:0] computation_mode_sel;
    wire display_mode_reg_en;
    
    
    
    Controller DUT(
    .clk(clk),
    .rst(rst),
    .start(start),  // start overall flow(initialize memory -> serial -> systolic -> custom -> display)
    
    // done signal
    .serial_mode_done(serial_mode_done),
    .weight_Preloader_done(weight_Preloader_done),
    .feature_Loader_done(feature_Loader_done),
    .custom_mode_done(custom_mode_done),
    .display_done(display_done),

    // rst signal
    .rst_computation_module(rst_computation_module),
    .rst_display_module(rst_display_module),
    
    // data & addr 
    .data(data),
    .addr_0(addr_0),

    // mem selct signal(controller || computation)
    .mem_sel(mem_sel), 
    
    // base address(refer serial&systolic data_loader report)
    .serial_mode_feature_baseaddr(serial_mode_feature_baseaddr),
    .systolic_mode_feature_baseaddr(systolic_mode_feature_baseaddr),
    
    // enable select signal
    .serial_mode_en(serial_mode_en),
    .Weight_Preloader_en(Weight_Preloader_en),
    .Feature_Loader_en(Feature_Loader_en),
    .custom_mode_en(custom_mode_en),
    .systolic_mode(systolic_mode),   // weight perload or feature load
    .c_reg_sel(c_reg_sel), // select c11 or c12 or c21 or c22 to store result
    .computation_mode_sel(computation_mode_sel),
    .display_mode_reg_en(display_mode_reg_en)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        #0  rst = 1'b0; // reset
            clk = 1'b0; // clk reset
        #3  rst = 1'b1; // reset off
            
        // wait for readability
        repeat(3) begin
            @(posedge clk);
        end
            
        #3  start = 1'b1;   // give start signal
        @(posedge clk);
        @(posedge clk);
        #3  start = 1'b0;
        
        // wait initialize memory(>25)
        repeat(26) begin
            @(posedge clk);
        end

        // memory initialize finisehd -> serial stride1 start //

        // wait serial_mode 1st stride
        repeat(3) begin
            @(posedge clk);
        end        
        // Here control must be wait for serial 1st stride done signal
        #3  serial_mode_done = 1'b1;    // give done signal
        @(posedge clk);
        #3  serial_mode_done = 1'b0;    // done signal off
        
        
        // wait serial_mode 2nd stride
        repeat(3) begin
            @(posedge clk);
        end
        // Here control must be wait for serial 2nd stride done signal
        #3  serial_mode_done = 1'b1;    // give done signal
        @(posedge clk);
        #3  serial_mode_done = 1'b0;    // done signal off
            
            
        // wait serial_mode 3rd stride
        repeat(3) begin
            @(posedge clk);
        end
        // Here control must be wait for serial 3rd stride done signal
        #3  serial_mode_done = 1'b1;    // give done signal
        @(posedge clk);
        #3  serial_mode_done = 1'b0;    // done signal off
            
        
        // wait serial_mode 4th stride
        repeat(3) begin
            @(posedge clk);
        end
        // Here control must be wait for serial 4th stride done signal
        #3  serial_mode_done = 1'b1;    // give done signal
        @(posedge clk);
        #3  serial_mode_done = 1'b0;    // done signal off
        
        
        // serial finished -> systolic weight preload start //
        
        // wait weight preload
        repeat(3) begin
            @(posedge clk);
        end
        // Here control wait for weight_preloader_done signal
        #3  weight_Preloader_done = 1'b1;
        @(posedge clk);
        #3  weight_Preloader_done = 1'b0;
        
        
        // weight preload finished -> systolic stirde start //
        
        // wait stride1 feature preload
        repeat(3) begin
            @(posedge clk);
        end
        // Here control wait for feature_preloader_done signal
        #3  feature_Loader_done = 1'b1;
        @(posedge clk);
        #3  feature_Loader_done = 1'b0;
        
        
        // wait stride2 feature preload
        repeat(3) begin
            @(posedge clk);
        end
        // Here control wait for feature_preloader_done signal
        #3  feature_Loader_done = 1'b1;
        @(posedge clk);
        #3  feature_Loader_done = 1'b0;
        
        
        // wait stride3 feature preload
        repeat(3) begin
            @(posedge clk);
        end
        // Here control wait for feature_preloader_done signal
        #3  feature_Loader_done = 1'b1;
        @(posedge clk);
        #3  feature_Loader_done = 1'b0;
        
        
        // wait stride4 feature preload
        repeat(3) begin
            @(posedge clk);
        end
        // Here control wait for feature_preloader_done signal
        #3  feature_Loader_done = 1'b1;
        @(posedge clk);
        #3  feature_Loader_done = 1'b0;
        
        
        //! systolic operation need 3cycle delay for getting output feature
        repeat(4) begin
            @(posedge clk);
        end
        
        
        // systolic finisehd -> custom start //
        
        // wait custom mode operation
        repeat(5) begin
            @(posedge clk);
        end
        // give custom mode done signal
        #3  custom_mode_done = 1'b1;
        @(posedge clk);
        #3  custom_mode_done = 1'b0;
        
        
        // custom mode finishsed -> Display mode start //
        // wait display module activation
        repeat(3) begin
            @(posedge clk);
        end
        // give display mode done signal
        #3  display_done = 1'b1;
        @(posedge clk);
        #3  display_done = 1'b0;
        
        
    end
    
endmodule

