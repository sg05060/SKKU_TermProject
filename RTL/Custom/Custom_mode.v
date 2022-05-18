module Custom_mode(

    input clk,                  // from fsm
    input rst,                  // from fsm
    input en,                   // from fsm
    
    input   [7:0]   data_i,     // from memory
    
    output  [5:0]   addr_o,     // to memory
    
    output  [7:0]   c11,
    output  [7:0]   c12,
    output  [7:0]   c21,
    output  [7:0]   c22,
    
    output          is_done_o   // to fsm
);

    wire    [7:0]   demux_sel;
    wire    [3:0]   acc_en;
    wire    [3:0]   weight_en;
    wire    [3:0]   feature_en;
    
    wire    [7:0]   mem_data;

    Custom_Data_Loader Custom_Data_Loader_inst(
    
    .clk            (clk),
    .rst            (rst),
    .en             (en),
    
    .mem_data_i     (data_i),

    .is_done_o      (is_done_o),
    
    .addr_o         (addr_o),
    
    .demux_sel_o    (demux_sel),
    .acc_en_o       (acc_en),
    .weight_en_o    (weight_en),
    .feature_en_o   (feature_en),
    
    .mem_data_o     (mem_data)
    
    );

    Custom_TOP Custom_Top_inst(

    // basic signal
    .clk            (clk),
    .rst            (rst),
    
    // Controll signal
    .sel_demux      (demux_sel),
    .acc_en         (acc_en),
    .weight_en      (weight_en),
    .feature_en     (feature_en),

    // mem data
    .data_in        (mem_data),
    
    // convolution out feature map
    .c11            (c11),
    .c12            (c12),
    .c21            (c21),
    .c22            (c22)
    
);

endmodule