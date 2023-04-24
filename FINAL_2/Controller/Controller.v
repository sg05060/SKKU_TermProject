module Controller(
    input   clk,
    input   rst,
    input   start,  // start overall flow(initialize memory -> serial -> systolic -> custom -> display)
    
    // done signal
    input   serial_mode_done,
    input   weight_Preloader_done,
    input   feature_Loader_done,
    input   custom_mode_done,
    input   display_done,

    // rst signal
    output reg rst_computation_module,
    output reg rst_display_module,
    
    // data & addr 
    output reg [7:0] data,
    output reg [5:0] addr_0,

    // mem selct signal(controller || computation)
    output reg mem_sel, 
    
    // base address(refer serial&systolic data_loader report)
    output reg [7:0] serial_mode_feature_baseaddr,
    output reg [5:0] systolic_mode_feature_baseaddr,
    
    // enable select signal
    output reg serial_mode_en,
    output reg Weight_Preloader_en,
    output reg Feature_Loader_en,
    output reg custom_mode_en,
    output reg systolic_mode,   // weight perload or feature load
    output reg [1:0] c_reg_sel, // select c11 or c12 or c21 or c22 to store result
    output reg [1:0] computation_mode_sel,
    output reg display_mode_reg_en

);
    // input feature & weight value
    // (if you need checking activation with other user own value, modify these)
    
    // initialize feature input
    parameter a11 = 8'b0000_0001, a12 = 8'b0000_0010, a13 = 8'b0000_0011, a14 = 8'b0000_0100;
    parameter a21 = 8'b0000_0001, a22 = 8'b0000_0010, a23 = 8'b0000_0011, a24 = 8'b0000_0100;
    parameter a31 = 8'b0000_0001, a32 = 8'b0000_0010, a33 = 8'b0000_0011, a34 = 8'b0000_0100;
    parameter a41 = 8'b0000_0001, a42 = 8'b0000_0010, a43 = 8'b0000_0011, a44 = 8'b0000_0100;
    
    // initialize weight input
    parameter b11 = 8'b0000_0001, b12 = 8'b0000_0010, b13 = 8'b0000_0011;
    parameter b21 = 8'b0000_0001, b22 = 8'b0000_0010, b23 = 8'b0000_0011;
    parameter b31 = 8'b0000_0001, b32 = 8'b0000_0010, b33 = 8'b0000_0011;

    // state parameter 
    parameter S_RESET                           = 6'b00_0000;
    parameter S_MEM_INIT_0                      = 6'b00_0001;
    parameter S_MEM_INIT_1                      = 6'b00_0010;
    parameter S_MEM_INIT_2                      = 6'b00_0011;
    parameter S_MEM_INIT_3                      = 6'b00_0100;
    parameter S_MEM_INIT_4                      = 6'b00_0101;
    parameter S_MEM_INIT_5                      = 6'b00_0110;
    parameter S_MEM_INIT_6                      = 6'b00_0111;
    parameter S_MEM_INIT_7                      = 6'b00_1000;
    parameter S_MEM_INIT_8                      = 6'b00_1001;
    parameter S_MEM_INIT_9                      = 6'b00_1010;
    parameter S_MEM_INIT_10                     = 6'b00_1011;
    parameter S_MEM_INIT_11                     = 6'b00_1100;
    parameter S_MEM_INIT_12                     = 6'b00_1101;
    parameter S_MEM_INIT_13                     = 6'b00_1110;
    parameter S_MEM_INIT_14                     = 6'b00_1111;
    parameter S_MEM_INIT_15                     = 6'b01_0000;
    parameter S_MEM_INIT_16                     = 6'b01_0001;
    parameter S_MEM_INIT_17                     = 6'b01_0010;
    parameter S_MEM_INIT_18                     = 6'b01_0011;
    parameter S_MEM_INIT_19                     = 6'b01_0100;
    parameter S_MEM_INIT_20                     = 6'b01_0101;
    parameter S_MEM_INIT_21                     = 6'b01_0110;
    parameter S_MEM_INIT_22                     = 6'b01_0111;
    parameter S_MEM_INIT_23                     = 6'b01_1000;
    parameter S_MEM_INIT_24                     = 6'b01_1001;

    parameter S_SERIAL_MODE_STRIDE_1            = 6'b01_1010;
    parameter S_SERIAL_MODE_STRIDE_2            = 6'b01_1011;
    parameter S_SERIAL_MODE_STRIDE_3            = 6'b01_1100;
    parameter S_SERIAL_MODE_STRIDE_4            = 6'b01_1101;
    parameter S_SERIAL_MODE_WAIT                = 6'b01_1110;
    parameter S_SERIAL_MODE_DONE                = 6'b01_1111;

    parameter S_SYSTOLIC_MODE_WEIGHT_PRELOAD    = 6'b10_0000;
    parameter S_SYSTOLIC_MODE_STRIDE_1          = 6'b10_0001;
    parameter S_SYSTOLIC_MODE_STRIDE_2          = 6'b10_0010;
    parameter S_SYSTOLIC_MODE_STRIDE_3          = 6'b10_0011;
    parameter S_SYSTOLIC_MODE_STRIDE_4          = 6'b10_0100;
    parameter S_SYSTOLIC_MODE_WAIT_1            = 6'b10_0101;
    parameter S_SYSTOLIC_MODE_WAIT_2            = 6'b10_0110;
    parameter S_SYSTOLIC_MODE_WAIT_3            = 6'b10_0111;
    parameter S_SYSTOLIC_MODE_DONE              = 6'b10_1000;

    parameter S_CUSTOM_MODE_EN                  = 6'b10_1001;
    parameter S_CUSTOM_MODE_DONE                = 6'b10_1010;

    parameter S_DISPLAY_MODE_EN                 = 6'b10_1011;
    parameter S_DISPLAY_MODE_DONE               = 6'b10_1100;


    reg [6:0] next_state;
    reg [6:0] current_state;

    
    // state update
    always @(posedge clk) begin
        if(rst == 0) begin
            current_state <= S_RESET;
        end else begin
            current_state <= next_state;
        end
    end

    
    // declare next state
    always @(*) begin
        next_state = S_RESET;
        case(current_state)
            
            // reset overall module
            S_RESET         :   if(start)
                                    next_state = S_MEM_INIT_0;
                                else
                                    next_state = S_RESET;
            
            // memroy initialize
            S_MEM_INIT_0    :   next_state = S_MEM_INIT_1;
            S_MEM_INIT_1    :   next_state = S_MEM_INIT_2;
            S_MEM_INIT_2    :   next_state = S_MEM_INIT_3;
            S_MEM_INIT_3    :   next_state = S_MEM_INIT_4;
            S_MEM_INIT_4    :   next_state = S_MEM_INIT_5;
            S_MEM_INIT_5    :   next_state = S_MEM_INIT_6;
            S_MEM_INIT_6    :   next_state = S_MEM_INIT_7;
            S_MEM_INIT_7    :   next_state = S_MEM_INIT_8;
            S_MEM_INIT_8    :   next_state = S_MEM_INIT_9;
            S_MEM_INIT_9    :   next_state = S_MEM_INIT_10;
            S_MEM_INIT_10   :   next_state = S_MEM_INIT_11;
            S_MEM_INIT_11   :   next_state = S_MEM_INIT_12;
            S_MEM_INIT_12   :   next_state = S_MEM_INIT_13;
            S_MEM_INIT_13   :   next_state = S_MEM_INIT_14;
            S_MEM_INIT_14   :   next_state = S_MEM_INIT_15;
            S_MEM_INIT_15   :   next_state = S_MEM_INIT_16;
            S_MEM_INIT_16   :   next_state = S_MEM_INIT_17;
            S_MEM_INIT_17   :   next_state = S_MEM_INIT_18;
            S_MEM_INIT_18   :   next_state = S_MEM_INIT_19;
            S_MEM_INIT_19   :   next_state = S_MEM_INIT_20;
            S_MEM_INIT_20   :   next_state = S_MEM_INIT_21;
            S_MEM_INIT_21   :   next_state = S_MEM_INIT_22;
            S_MEM_INIT_22   :   next_state = S_MEM_INIT_23;
            S_MEM_INIT_23   :   next_state = S_MEM_INIT_24;
            S_MEM_INIT_24   :   next_state = S_SERIAL_MODE_STRIDE_1;  // initilize done(init -> serial)


            // serial stride start
            S_SERIAL_MODE_STRIDE_1  :   if(serial_mode_done)
                                            next_state = S_SERIAL_MODE_STRIDE_2;
                                        else
                                            next_state = S_SERIAL_MODE_STRIDE_1;
            S_SERIAL_MODE_STRIDE_2  :   if(serial_mode_done)
                                            next_state = S_SERIAL_MODE_STRIDE_3;
                                        else
                                            next_state = S_SERIAL_MODE_STRIDE_2;
            S_SERIAL_MODE_STRIDE_3  :   if(serial_mode_done)
                                            next_state = S_SERIAL_MODE_STRIDE_4;
                                        else
                                            next_state = S_SERIAL_MODE_STRIDE_3;   
            S_SERIAL_MODE_STRIDE_4  :   if(serial_mode_done)
                                            next_state = S_SERIAL_MODE_WAIT;
                                        else
                                            next_state = S_SERIAL_MODE_STRIDE_4;
            
            // serial mode wait for weight reset in PE
            S_SERIAL_MODE_WAIT      :  next_state = S_SERIAL_MODE_DONE;
            
            // serial mode done(serial -> systolic)
            S_SERIAL_MODE_DONE      :  next_state = S_SYSTOLIC_MODE_WEIGHT_PRELOAD;


            // weight preload in systolic module
            S_SYSTOLIC_MODE_WEIGHT_PRELOAD  : 
                                            if(weight_Preloader_done)
                                                next_state = S_SYSTOLIC_MODE_STRIDE_1;
                                            else
                                                next_state = S_SYSTOLIC_MODE_WEIGHT_PRELOAD;
            S_SYSTOLIC_MODE_STRIDE_1: 
                                            if(feature_Loader_done)
                                                next_state = S_SYSTOLIC_MODE_STRIDE_2;
                                            else
                                                next_state = S_SYSTOLIC_MODE_STRIDE_1;
            S_SYSTOLIC_MODE_STRIDE_2          : 
                                            if(feature_Loader_done)
                                                next_state = S_SYSTOLIC_MODE_STRIDE_3;
                                            else
                                                next_state = S_SYSTOLIC_MODE_STRIDE_2;
            S_SYSTOLIC_MODE_STRIDE_3          : 
                                            if(feature_Loader_done)
                                                next_state = S_SYSTOLIC_MODE_STRIDE_4;
                                            else
                                                next_state = S_SYSTOLIC_MODE_STRIDE_3;
            S_SYSTOLIC_MODE_STRIDE_4          : 
                                            if(feature_Loader_done)
                                                next_state = S_SYSTOLIC_MODE_WAIT_1;
                                            else
                                                next_state = S_SYSTOLIC_MODE_STRIDE_4;
            
            
            // systolic wait state(systolic need 3cycle delay for finish all computation)
            S_SYSTOLIC_MODE_WAIT_1            : next_state = S_SYSTOLIC_MODE_WAIT_2;
            S_SYSTOLIC_MODE_WAIT_2            : next_state = S_SYSTOLIC_MODE_WAIT_3;
            S_SYSTOLIC_MODE_WAIT_3            : next_state = S_SYSTOLIC_MODE_DONE;
            S_SYSTOLIC_MODE_DONE              : next_state = S_CUSTOM_MODE_EN;  // systolic finsih(systolic -> custom)
            
            // custom mode start
            // In this module, we used data_loader concept. If you need to know each cycle control signal, 
            // please refer custom_doc file in /TOP_DIRECTORY/FINAL_2/Custom/Custom_Doc/Custom_CNN_TOP_Control/sig.txt
            // Explanation of each signal, please refer report 
            S_CUSTOM_MODE_EN                  : 
                                                if(custom_mode_done)
                                                    next_state = S_CUSTOM_MODE_DONE;
                                                else
                                                    next_state = S_CUSTOM_MODE_EN;
            
            S_CUSTOM_MODE_DONE                : next_state = S_DISPLAY_MODE_EN; // custom finish(custom -> display)


            // display start
            S_DISPLAY_MODE_EN               : 
                                                if(display_done)
                                                    next_state = S_DISPLAY_MODE_DONE;
                                                else
                                                    next_state = S_DISPLAY_MODE_EN;
            
            S_DISPLAY_MODE_DONE             : next_state = S_RESET;


        endcase
    end


    // fsm output(decided only by state) -> moore machine
    always @(*) begin
    
        // exception value(default for preventing latch)
        rst_computation_module          = 1'b1;
        rst_display_module              = 1'b1;
        addr_0                          = 6'b0;
        mem_sel                         = 0;
        serial_mode_feature_baseaddr    = 8'b0;
        systolic_mode_feature_baseaddr  = 6'b0;
        serial_mode_en                  = 1'b0;
        Weight_Preloader_en             = 1'b0;
        Feature_Loader_en               = 1'b0;
        systolic_mode                   = 1'b0;
        c_reg_sel                       = 2'b00;
        computation_mode_sel            = 2'b00;
        display_mode_reg_en             = 1'b0;
        custom_mode_en                  = 1'b0;
        
        case(current_state)
            S_RESET         :   begin
                                    rst_computation_module          = 1'b1;
                                    rst_display_module              = 1'b1;
                                    addr_0                          = 6'b0;
                                    mem_sel                         = 0;
                                    serial_mode_feature_baseaddr    = 8'b0;
                                    systolic_mode_feature_baseaddr  = 6'b0;
                                    serial_mode_en                  = 1'b0;
                                    Weight_Preloader_en             = 1'b0;
                                    Feature_Loader_en               = 1'b0;
                                    systolic_mode                   = 1'b0;
                                    c_reg_sel                       = 2'b00;
                                    computation_mode_sel            = 2'b00;
                                    display_mode_reg_en             = 1'b0;
                                    custom_mode_en                  = 1'b0;
                                end

            // mem initialize
            S_MEM_INIT_0    :   begin
                                    addr_0  = 6'b00_0000;
                                    data    = b11;
                                end
                                
            S_MEM_INIT_1    :   begin
                                    addr_0  = 6'b00_0001;
                                    data    = b21;
                                end
                                
            S_MEM_INIT_2    :   begin
                                    addr_0  = 6'b00_0010;
                                    data    = b31;
                                end
                                
            S_MEM_INIT_3    :   begin
                                    addr_0  = 6'b00_0011;
                                    data    = b12;
                                end
                                
            S_MEM_INIT_4    :   begin
                                    addr_0  = 6'b00_0100;
                                    data    = b22;
                                end
                                
            S_MEM_INIT_5    :   begin
                                    addr_0  = 6'b00_0101;
                                    data    = b32;
                                end
                                
            S_MEM_INIT_6    :   begin
                                    addr_0  = 6'b00_0110;
                                    data    = b13;
                                end
                                
            S_MEM_INIT_7    :   begin
                                    addr_0  = 6'b00_0111;
                                    data    = b23;
                                end
                                
            S_MEM_INIT_8    :   begin
                                    addr_0  = 6'b00_1000;
                                    data    = b33;
                                end
                                
            S_MEM_INIT_9    :   begin
                                    addr_0  = 6'b00_1001;
                                    data    = a11;
                                end
            S_MEM_INIT_10    :   begin
                                    addr_0  = 6'b00_1010;
                                    data    = a12;
                                end
            S_MEM_INIT_11    :   begin
                                    addr_0  = 6'b00_1011;
                                    data    = a13;
                                end
            S_MEM_INIT_12    :   begin
                                    addr_0  = 6'b00_1100;
                                    data    = a14;
                                end
            S_MEM_INIT_13    :   begin
                                    addr_0  = 6'b00_1101;
                                    data    = a21;
                                end
            S_MEM_INIT_14    :   begin
                                    addr_0  = 6'b00_1110;
                                    data    = a22;
                                end
            S_MEM_INIT_15    :   begin
                                    addr_0  = 6'b00_1111;
                                    data    = a23;
                                end
            S_MEM_INIT_16    :   begin
                                    addr_0  = 6'b01_0000;
                                    data    = a24;
                                end
            S_MEM_INIT_17    :   begin
                                    addr_0  = 6'b01_0001;
                                    data    = a31;
                                end
            S_MEM_INIT_18    :   begin
                                    addr_0  = 6'b01_0010;
                                    data    = a32;
                                end
            S_MEM_INIT_19    :   begin
                                    addr_0  = 6'b01_0011;
                                    data    = a33;
                                end   
            S_MEM_INIT_20    :   begin
                                    addr_0  = 6'b01_0100;
                                    data    = a34;
                                end
            S_MEM_INIT_21    :   begin
                                    addr_0  = 6'b01_0101;
                                    data    = a41;
                                end            
            S_MEM_INIT_22    :   begin
                                    addr_0  = 6'b01_0110;
                                    data    = a42;
                                end
            S_MEM_INIT_23    :   begin
                                    addr_0  = 6'b01_0111;
                                    data    = a43;
                                end
            S_MEM_INIT_24    :   begin
                                    addr_0  = 6'b01_1000;
                                    data    = a44;
                                    rst_computation_module = 1'b0;
                                end

            // serial
            S_SERIAL_MODE_STRIDE_1  :   begin
                                            rst_computation_module = 1'b0;
                                            mem_sel = 1'b1;
                                            serial_mode_en = 1'b1;
                                            computation_mode_sel = 2'b00;
                                            serial_mode_feature_baseaddr = 6'b00_1001;
                                        end
            S_SERIAL_MODE_STRIDE_2  :   begin
                                            rst_computation_module = 1'b0;
                                            mem_sel = 1'b1;
                                            serial_mode_en = 1'b1;
                                            computation_mode_sel = 2'b00;
                                            serial_mode_feature_baseaddr = 6'b00_1010;
                                        end
                                            
            S_SERIAL_MODE_STRIDE_3  :   begin
                                            rst_computation_module = 1'b0;
                                            mem_sel = 1'b1;
                                            serial_mode_en = 1'b1;
                                            computation_mode_sel = 2'b00;
                                            serial_mode_feature_baseaddr = 6'b00_1101;
                                        end
                                        
            S_SERIAL_MODE_STRIDE_4  :   begin
                                            rst_computation_module = 1'b0;
                                            mem_sel = 1'b1;
                                            serial_mode_en = 1'b1;
                                            computation_mode_sel = 2'b00;
                                            serial_mode_feature_baseaddr = 6'b00_1110;
                                        end  
            S_SERIAL_MODE_WAIT      :   begin
                                            rst_computation_module = 1'b0;
                                            mem_sel = 1'b1;
                                            serial_mode_en = 1'b0;
                                            computation_mode_sel = 2'b00;
                                        end
            S_SERIAL_MODE_DONE      :   begin
                                            rst_computation_module = 1'b0;
                                            mem_sel = 1'b1;
                                            serial_mode_en = 1'b0;
                                            computation_mode_sel = 2'b00;
                                        end
                                    

            // systolic
            S_SYSTOLIC_MODE_WEIGHT_PRELOAD  :   begin
                                                    mem_sel = 1'b1;
                                                    rst_computation_module = 1'b0;
                                                    computation_mode_sel = 2'b01;
                                                    Weight_Preloader_en = 1'b1;
                                                    systolic_mode = 1'b0;
                                                end 
            S_SYSTOLIC_MODE_STRIDE_1          : begin
                                                    mem_sel = 1'b1;
                                                    rst_computation_module = 1'b0;
                                                    computation_mode_sel = 2'b01;
                                                    Weight_Preloader_en = 1'b0;
                                                    Feature_Loader_en = 1'b1;
                                                    systolic_mode = 1'b1;
                                                    systolic_mode_feature_baseaddr = 6'b00_1001;
                                                    c_reg_sel = 2'b00;
                                                end
            S_SYSTOLIC_MODE_STRIDE_2          : begin
                                                    mem_sel = 1'b1;
                                                    rst_computation_module = 1'b0;
                                                    computation_mode_sel = 2'b01;
                                                    Weight_Preloader_en = 1'b0;
                                                    Feature_Loader_en = 1'b1;
                                                    systolic_mode = 1'b1;
                                                    systolic_mode_feature_baseaddr = 6'b00_1010;
                                                    c_reg_sel = 2'b01;
                                                end
                                                
            S_SYSTOLIC_MODE_STRIDE_3          : begin
                                                    mem_sel = 1'b1;
                                                    rst_computation_module = 1'b0;
                                                    computation_mode_sel = 2'b01;
                                                    Weight_Preloader_en = 1'b0;
                                                    Feature_Loader_en = 1'b1;
                                                    systolic_mode = 1'b1;
                                                    systolic_mode_feature_baseaddr = 6'b00_1101;
                                                    c_reg_sel = 2'b10;
                                                end
            S_SYSTOLIC_MODE_STRIDE_4          : begin
                                                    mem_sel = 1'b1;
                                                    rst_computation_module = 1'b0;
                                                    computation_mode_sel = 2'b01;
                                                    Weight_Preloader_en = 1'b0;
                                                    Feature_Loader_en = 1'b1;
                                                    systolic_mode = 1'b1;
                                                    systolic_mode_feature_baseaddr = 6'b00_1110;
                                                    c_reg_sel = 2'b11;
                                                end
            S_SYSTOLIC_MODE_WAIT_1            : begin
                                                    mem_sel = 1'b1;
                                                    rst_computation_module = 1'b0;
                                                    computation_mode_sel = 2'b01;
                                                    Weight_Preloader_en = 1'b0;
                                                    Feature_Loader_en = 1'b0;
                                                    systolic_mode = 1'b1;
                                                end
                                                
            S_SYSTOLIC_MODE_WAIT_2            : begin 
                                                    mem_sel = 1'b1;
                                                    rst_computation_module = 1'b0;
                                                    computation_mode_sel = 2'b01;
                                                    Weight_Preloader_en = 1'b0;
                                                    Feature_Loader_en = 1'b0;
                                                    systolic_mode = 1'b1;
                                                end
            S_SYSTOLIC_MODE_WAIT_3            : begin
                                                    mem_sel = 1'b1;
                                                    rst_computation_module = 1'b0;
                                                    computation_mode_sel = 2'b01;
                                                    Weight_Preloader_en = 1'b0;
                                                    Feature_Loader_en = 1'b0;
                                                    systolic_mode = 1'b1;
                                                end
                                                
            S_SYSTOLIC_MODE_DONE              : begin
                                                    mem_sel = 1'b1;
                                                    rst_computation_module = 1'b0;
                                                    computation_mode_sel    = 2'b10;
                                                    custom_mode_en          = 1'b1;
                                                end

            // custom
            S_CUSTOM_MODE_EN                  : begin
                                                    mem_sel = 1'b1;
                                                    rst_computation_module  = 1'b0;
                                                    computation_mode_sel    = 2'b10;
                                                    custom_mode_en          = 1'b1;
                                                end
            S_CUSTOM_MODE_DONE                : begin
                                                    mem_sel = 1'b1;
                                                    rst_computation_module  = 1'b1;
                                                    computation_mode_sel    = 2'b10;
                                                    custom_mode_en          = 1'b0;
                                                    rst_display_module = 1'b0;
                                                    display_mode_reg_en = 1'b1;
                                                end
            
            // display
            S_DISPLAY_MODE_EN               : begin
                                                    mem_sel = 1'b1;
                                                    rst_computation_module  = 1'b1;
                                                    computation_mode_sel    = 2'b10;
                                                    rst_display_module = 1'b0;
                                                    display_mode_reg_en = 1'b0;
                                                end
            S_DISPLAY_MODE_DONE               : begin
                                                    mem_sel = 1'b1;
                                                    rst_display_module = 1'b1;
                                                    display_mode_reg_en = 1'b0;
                                                end
        endcase
    end

endmodule