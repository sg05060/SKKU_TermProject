module Controller(
    input clk,
    input rst,
    input start,
    input serial_mode_done,
    input weight_Preloader_done,
    input feature_Loader_done,

    input display_done,

    output reg rst_computation_module,
    output reg rst_display_module,
    output reg [7:0] data,
    output reg [5:0] addr_0,
    output reg we_0,

    output reg mem_sel, 
    output reg [7:0] serial_mode_feature_baseaddr,
    output reg [5:0] systolic_mode_feature_baseaddr,
    output reg serial_mode_en,
    output reg Weight_Preloader_en,
    output reg Feature_Loader_en,
    output reg systolic_mode, // weight perload or feature load
    output reg [1:0] c_reg_sel, // select c11 or c12 or c21 or c22 to store result
    output reg computation_mode_sel,
    output reg display_mode_en

);
    parameter a11 = 8'b0000_0001, a12 = 8'b0000_0010, a13 = 8'b0000_0011, a14 = 8'b0000_0100,
              a21 = 8'b0000_0001, a22 = 8'b0000_0010, a23 = 8'b0000_0011, a24 = 8'b0000_0100,
              a31 = 8'b0000_0001, a32 = 8'b0000_0010, a33 = 8'b0000_0011, a34 = 8'b0000_0100,
              a41 = 8'b0000_0001, a42 = 8'b0000_0010, a43 = 8'b0000_0011, a44 = 8'b0000_0100;
    parameter b11 = 8'b0000_0001, b12 = 8'b0000_0010, b13 = 8'b0000_0011,
              b21 = 8'b0000_0001, b22 = 8'b0000_0010, b23 = 8'b0000_0011,
              b31 = 8'b0000_0001, b32 = 8'b0000_0010, b33 = 8'b0000_0011;

    parameter S_RESET           = 7'b000_0000;
    parameter S_MEM_INIT_0      = 7'b000_0001;
    parameter S_MEM_INIT_1      = 7'b000_0010;
    parameter S_MEM_INIT_2      = 7'b000_0011;
    parameter S_MEM_INIT_3      = 7'b000_0100;
    parameter S_MEM_INIT_4      = 7'b000_0101;
    parameter S_MEM_INIT_5      = 7'b000_0110;
    parameter S_MEM_INIT_6      = 7'b000_0111;
    parameter S_MEM_INIT_7      = 7'b000_1000;
    parameter S_MEM_INIT_8      = 7'b000_1001;
    parameter S_MEM_INIT_9      = 7'b000_1010;
    parameter S_MEM_INIT_10     = 7'b000_1011;
    parameter S_MEM_INIT_11     = 7'b000_1100;
    parameter S_MEM_INIT_12     = 7'b000_1101;
    parameter S_MEM_INIT_13     = 7'b000_1110;
    parameter S_MEM_INIT_14     = 7'b000_1111;
    parameter S_MEM_INIT_15     = 7'b001_0000;
    parameter S_MEM_INIT_16     = 7'b001_0001;
    parameter S_MEM_INIT_17     = 7'b001_0010;
    parameter S_MEM_INIT_18     = 7'b001_0011;
    parameter S_MEM_INIT_19     = 7'b001_0100;
    parameter S_MEM_INIT_20     = 7'b001_0101;
    parameter S_MEM_INIT_21     = 7'b001_0110;
    parameter S_MEM_INIT_22     = 7'b001_0111;
    parameter S_MEM_INIT_23     = 7'b001_1000;
    parameter S_MEM_INIT_24     = 7'b001_1001;

    parameter S_SERIAL_MODE_STRIDE_1 = 7'b001_1010;
    parameter S_SERIAL_MODE_STRIDE_2 = 7'b001_1011;
    parameter S_SERIAL_MODE_STRIDE_3 = 7'b001_1100;
    parameter S_SERIAL_MODE_STRIDE_4 = 7'b001_1101;
    parameter S_SERIAL_MODE_WAIT     = 7'b001_1110;
    parameter S_SERIAL_MODE_DONE     = 7'b001_1111;

    parameter S_SYSTOLIC_MODE_WEIGHT_PRELOAD = 7'b010_0000;
    parameter S_SYSTOLIC_MODE_STRIDE_1 = 7'b010_0001;
    parameter S_SYSTOLIC_MODE_STRIDE_2 = 7'b010_0010;
    parameter S_SYSTOLIC_MODE_STRIDE_3 = 7'b010_0011;
    parameter S_SYSTOLIC_MODE_STRIDE_4 = 7'b010_0100;
    parameter S_SYSTOLIC_MODE_WAIT_1   = 7'b010_0101;
    parameter S_SYSTOLIC_MODE_WAIT_2   = 7'b010_0110;
    parameter S_SYSTOLIC_MODE_WAIT_3   = 7'b010_0111;
    parameter S_SYSTOLIC_MODE_DONE     = 7'b010_1000;

    parameter S_DISPLAY_MODE_EN = 7'b010_1001;
    parameter S_DISPLAY_MODE_DONE = 7'b010_1010;


    reg [6:0] next_state;
    reg [6:0] current_state;

    always @(posedge clk) begin
        if(rst == 0) begin
            current_state <= S_RESET;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = S_RESET;
        case(current_state)
            S_RESET         :   if(start)
                                    next_state = S_MEM_INIT_0;
                                else
                                    next_state = S_RESET;
            S_MEM_INIT_0    :   
                                    next_state = S_MEM_INIT_1;
            S_MEM_INIT_1    :   
                                    next_state = S_MEM_INIT_2;
            S_MEM_INIT_2    :   
                                    next_state = S_MEM_INIT_3;
            S_MEM_INIT_3    :   
                                    next_state = S_MEM_INIT_4;
            S_MEM_INIT_4    :   
                                    next_state = S_MEM_INIT_5;
            S_MEM_INIT_5    :   
                                    next_state = S_MEM_INIT_6;
            S_MEM_INIT_6    :   
                                    next_state = S_MEM_INIT_7;
            S_MEM_INIT_7    :   
                                    next_state = S_MEM_INIT_8;
            S_MEM_INIT_8    :   
                                    next_state = S_MEM_INIT_9;
            S_MEM_INIT_9    :   
                                    next_state = S_MEM_INIT_10;
            S_MEM_INIT_10   :   
                                    next_state = S_MEM_INIT_11;
            S_MEM_INIT_11   :   
                                    next_state = S_MEM_INIT_12;
            S_MEM_INIT_12   :   
                                    next_state = S_MEM_INIT_13;
            S_MEM_INIT_13   :   
                                    next_state = S_MEM_INIT_14;
            S_MEM_INIT_14   :   
                                    next_state = S_MEM_INIT_15;
            S_MEM_INIT_15   :   
                                    next_state = S_MEM_INIT_16;
            S_MEM_INIT_16   :   
                                    next_state = S_MEM_INIT_17;
            S_MEM_INIT_17   :   
                                    next_state = S_MEM_INIT_18;
            S_MEM_INIT_18   :   
                                    next_state = S_MEM_INIT_19;
            S_MEM_INIT_19   :   
                                    next_state = S_MEM_INIT_20;
            S_MEM_INIT_20   :   
                                    next_state = S_MEM_INIT_21;
            S_MEM_INIT_21   :   
                                    next_state = S_MEM_INIT_22;
            S_MEM_INIT_22   :   
                                    next_state = S_MEM_INIT_23;
            S_MEM_INIT_23   :   
                                    next_state = S_MEM_INIT_24;
            S_MEM_INIT_24   :   
                                    next_state = S_SERIAL_MODE_STRIDE_1;

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
            S_SERIAL_MODE_WAIT      :  
                                            next_state = S_SERIAL_MODE_DONE;
            S_SERIAL_MODE_DONE      :  
                                            next_state = S_SYSTOLIC_MODE_WEIGHT_PRELOAD;



            S_SYSTOLIC_MODE_WEIGHT_PRELOAD  : if(weight_Preloader_done)
                                                next_state = S_SYSTOLIC_MODE_STRIDE_1;
                                              else
                                                next_state = S_SYSTOLIC_MODE_WEIGHT_PRELOAD;
            S_SYSTOLIC_MODE_STRIDE_1          : if(feature_Loader_done)
                                                next_state = S_SYSTOLIC_MODE_STRIDE_2;
                                              else
                                                next_state = S_SYSTOLIC_MODE_STRIDE_1;
            S_SYSTOLIC_MODE_STRIDE_2          : if(feature_Loader_done)
                                                next_state = S_SYSTOLIC_MODE_STRIDE_3;
                                              else
                                                next_state = S_SYSTOLIC_MODE_STRIDE_2;
            S_SYSTOLIC_MODE_STRIDE_3          : if(feature_Loader_done)
                                                next_state = S_SYSTOLIC_MODE_STRIDE_4;
                                              else
                                                next_state = S_SYSTOLIC_MODE_STRIDE_3;
            S_SYSTOLIC_MODE_STRIDE_4          : if(feature_Loader_done)
                                                next_state = S_SYSTOLIC_MODE_WAIT_1;
                                              else
                                                next_state = S_SYSTOLIC_MODE_STRIDE_4;
            S_SYSTOLIC_MODE_WAIT_1            : 
                                                next_state = S_SYSTOLIC_MODE_WAIT_2;
            S_SYSTOLIC_MODE_WAIT_2            : 
                                                next_state = S_SYSTOLIC_MODE_WAIT_3;
            S_SYSTOLIC_MODE_WAIT_3            : 
                                                next_state = S_SYSTOLIC_MODE_DONE;
            S_SYSTOLIC_MODE_DONE              : 
                                                next_state = S_DISPLAY_MODE_EN;
            

            S_DISPLAY_MODE_EN                 : if(display_done)
                                                    next_state = S_DISPLAY_MODE_DONE;
                                                    else
                                                    next_state = S_DISPLAY_MODE_EN;
            S_DISPLAY_MODE_DONE               : 
                                                    next_state = S_RESET;
        endcase
    end

    always @(*) begin
        case(current_state)
            S_RESET         :   begin
                                    rst_computation_module          = 1'b1;
                                    rst_display_module              = 1'b1;
                                    addr_0                          = 6'b0;
                                    we_0                            = 1'b0;
                                    mem_sel = 0;
                                    serial_mode_feature_baseaddr    = 8'b0;
                                    systolic_mode_feature_baseaddr  = 6'b0;
                                    serial_mode_en                  = 1'b0;
                                    Weight_Preloader_en             = 1'b0;
                                    Feature_Loader_en               = 1'b0;
                                    systolic_mode                   = 1'b0;
                                    c_reg_sel                       = 2'b00;
                                    computation_mode_sel            = 1'b0;
                                    display_mode_en                 = 1'b0;
                                end

            S_MEM_INIT_0    :   begin
                                    addr_0  = 6'b00_0000;
                                    data    = b11;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_1    :   begin
                                    addr_0  = 6'b00_0001;
                                    data    = b21;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_2    :   begin
                                    addr_0  = 6'b00_0010;
                                    data    = b31;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_3    :   begin
                                    addr_0  = 6'b00_0011;
                                    data    = b12;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_4    :   begin
                                    addr_0  = 6'b00_0100;
                                    data    = b22;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_5    :   begin
                                    addr_0  = 6'b00_0101;
                                    data    = b32;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_6    :   begin
                                    addr_0  = 6'b00_0110;
                                    data    = b13;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_7    :   begin
                                    addr_0  = 6'b00_0111;
                                    data    = b23;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_8    :   begin
                                    addr_0  = 6'b00_1000;
                                    data    = b33;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_9    :   begin
                                    addr_0  = 6'b00_1001;
                                    data    = a11;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_10    :   begin
                                    addr_0  = 6'b00_1010;
                                    data    = a12;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_11    :   begin
                                    addr_0  = 6'b00_1011;
                                    data    = a13;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_12    :   begin
                                    addr_0  = 6'b00_1100;
                                    data    = a14;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_13    :   begin
                                    addr_0  = 6'b00_1101;
                                    data    = a21;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_14    :   begin
                                    addr_0  = 6'b00_1110;
                                    data    = a22;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_15    :   begin
                                    addr_0  = 6'b00_1111;
                                    data    = a23;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_16    :   begin
                                    addr_0  = 6'b01_0000;
                                    data    = a24;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_17    :   begin
                                    addr_0  = 6'b01_0001;
                                    data    = a31;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_18    :   begin
                                    addr_0  = 6'b01_0010;
                                    data    = a32;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_19    :   begin
                                    addr_0  = 6'b01_0011;
                                    data    = a33;
                                    we_0    = 1'b1;
                                end   
            S_MEM_INIT_20    :   begin
                                    addr_0  = 6'b01_0100;
                                    data    = a34;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_21    :   begin
                                    addr_0  = 6'b01_0101;
                                    data    = a41;
                                    we_0    = 1'b1;
                                end            
            S_MEM_INIT_22    :   begin
                                    addr_0  = 6'b01_0110;
                                    data    = a42;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_23    :   begin
                                    addr_0  = 6'b01_0111;
                                    data    = a43;
                                    we_0    = 1'b1;
                                end
            S_MEM_INIT_24    :   begin
                                    addr_0  = 6'b01_1000;
                                    data    = a44;
                                    we_0    = 1'b1;
                                    rst_computation_module = 1'b0;
                                end

            S_SERIAL_MODE_STRIDE_1  :   begin
                                            mem_sel = 1'b1;
                                            serial_mode_en = 1'b1;
                                            serial_mode_feature_baseaddr = 6'b00_1001;
                                            computation_mode_sel = 1'b0;
                                        end
            S_SERIAL_MODE_STRIDE_2  :   begin
                                            serial_mode_feature_baseaddr = 6'b00_1010;
                                        end
                                            
            S_SERIAL_MODE_STRIDE_3  :   begin
                                            serial_mode_feature_baseaddr = 6'b00_1101;
                                        end
                                        
            S_SERIAL_MODE_STRIDE_4  :   begin
                                            serial_mode_feature_baseaddr = 6'b00_1110;
                                        end  
            S_SERIAL_MODE_WAIT      :   begin
                                            serial_mode_en = 1'b0;
                                        end
            S_SERIAL_MODE_DONE      :   begin end
                                    

            S_SYSTOLIC_MODE_WEIGHT_PRELOAD  :   begin
                                                    computation_mode_sel = 1'b1;
                                                    Weight_Preloader_en = 1'b1;
                                                    systolic_mode = 1'b0;
                                                end 
            S_SYSTOLIC_MODE_STRIDE_1          : begin
                                                    Weight_Preloader_en = 1'b0;
                                                    Feature_Loader_en = 1'b1;
                                                    systolic_mode = 1'b1;
                                                    systolic_mode_feature_baseaddr = 6'b00_1001;
                                                    c_reg_sel = 2'b00;
                                                end
            S_SYSTOLIC_MODE_STRIDE_2          : begin
                                                    systolic_mode_feature_baseaddr = 6'b00_1010;
                                                    c_reg_sel = 2'b01;
                                                end
                                                
            S_SYSTOLIC_MODE_STRIDE_3          : begin
                                                    systolic_mode_feature_baseaddr = 6'b00_1101;
                                                    c_reg_sel = 2'b10;
                                                end
            S_SYSTOLIC_MODE_STRIDE_4          : begin
                                                    systolic_mode_feature_baseaddr = 6'b00_1110;
                                                    c_reg_sel = 2'b11;
                                                end
            S_SYSTOLIC_MODE_WAIT_1            : begin
                                                    Feature_Loader_en = 1'b0;
                                                end
                                                
            S_SYSTOLIC_MODE_WAIT_2            : begin end
            S_SYSTOLIC_MODE_WAIT_3            : begin end
                                                
            S_SYSTOLIC_MODE_DONE              : begin
                                                    rst_computation_module = 1'b1;
                                                    rst_display_module = 1'b0;
                                                    display_mode_en = 1'b1;
                                                end
                                                
            

            S_DISPLAY_MODE_EN                 : begin 
                                                        display_mode_en = 1'b0;
                                                end
            S_DISPLAY_MODE_DONE               : begin
                                                    rst_display_module = 1'b1;
                                                end
        endcase
    end

endmodule