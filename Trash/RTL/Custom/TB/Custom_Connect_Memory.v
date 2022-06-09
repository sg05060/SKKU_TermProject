module Custom_mode_conntect_Memory(
    
    input           clk,
    input           rst,
    input           en,
    input           we,
    input   [7:0]   data_write,
    
    output          is_done_o,
    output  [7:0]   c11,
    output  [7:0]   c12,
    output  [7:0]   c21,
    output  [7:0]   c22
    
);

    wire    [7:0]   data;
    wire    [5:0]   addr;

    Custom_mode Custom_mode_inst(
        .clk        (clk),      // from fsm
        .rst        (rst),      // from fsm
        .en         (en),       // from fsm
        
        .data_i     (data),     // from memory
        
        .addr_o     (addr),     // to memory
        
        .c11        (c11),
        .c12        (c12),
        .c21        (c21),
        .c22        (c22),
        
        .is_done_o  (is_done_o)      // to fsm
    );

    single_port_ram_for_tb mem_inst(
        .data       (data_write),   // from fsm
        .addr       (addr),         // from custom_mode
        .we         (we),           // from fsm
        .clk        (clk),
        .q          (data)          // to custom_mode
    );



    endmodule