module Top_Custom_mode(
    input clk,
    input rst,
    input custom_mode_en,
    output custom_mode_done,
    output [7:0] c11_custom,
    output [7:0] c12_custom,
    output [7:0] c21_custom,
    output [7:0] c22_custom
);
    wire [7:0] q;
    wire [5:0] addr;
    Custom_mode Custom_mode(

            .clk(clk),                  // from fsm
            .rst(rst),                  // from fsm
            .en(custom_mode_en),                   // from fsm
            
            .data_i(q),     // from memory
            
            .addr_o(addr),     // to memory
            
            .c11(c11_custom),
            .c12(c12_custom),
            .c21(c21_custom),
            .c22(c22_custom),

            .is_done_o(custom_mode_done)   // to fsm
    );
    single_port_ram ram(
        .data(),
        .addr(addr),
        .we(1'b0), 
        .clk(clk),
        .q(q)
    );

endmodule