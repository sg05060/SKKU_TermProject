// finished test version1 in vivado simulator - using decoder with behavioral code(2022.05.19)
// finished test version2 in vivado simulator - using decoder change gatelevel, structural level(2022.05.26)
// version3 - modify some module, variable name for readability

module Custom_mode(

    // basic signal
    input clk,                  
    input rst,                  
    input en,                   // custom_mode enable signal (controller -> data_loader)
    
    // data (computational_module -> data_loader)
    input   [7:0]   data_i,     
    
    // address (data_loader -> computational_module)
    output  [5:0]   addr_o,     
    
    // output feature map
    output  [7:0]   c11,
    output  [7:0]   c12,
    output  [7:0]   c21,
    output  [7:0]   c22,
    
    // done signal (data_loader -> computational_module)
    output          is_done_o   
    
);

    // data_loader and custom_top wire port
    wire    [7:0]   demux_sel;
    wire    [3:0]   acc_en;
    wire    [3:0]   weight_en;
    wire    [3:0]   feature_en;
    
    wire    [7:0]   mem_data;
    wire    [3:0]   buff_use;


    // inst data_loader
    Custom_Data_Loader Custom_Data_Loader_inst(
    
        // basic signal
        .clk            (clk),
        .rst            (rst),
        .en             (en),
        
        // signal trans with data_loader and computational_module
        .mem_data_i     (data_i),       
        .is_done_o      (is_done_o),       
        .addr_o         (addr_o),             
        
        // control signal, mem_data (data_loader -> custom_top)
        .demux_sel_o    (demux_sel),
        .acc_en_o       (acc_en),
        .weight_en_o    (weight_en),
        .feature_en_o   (feature_en),
        .mem_data_o     (mem_data),
        .buff_use_o     (buff_use)
    );


    // inst custom_top
    Custom_TOP Custom_Top_inst(

        // basic signal
        .clk            (clk),
        .rst            (rst),
        
        // control signal
        .sel_demux      (demux_sel),
        .acc_en         (acc_en),
        .weight_en      (weight_en),
        .feature_en     (feature_en)
        .buff_mux_sel   (buff_use),
    
        // mem data
        .data_in        (mem_data),
        
        // convolution out feature map
        .c11            (c11),
        .c12            (c12),
        .c21            (c21),
        .c22            (c22)
    );


endmodule