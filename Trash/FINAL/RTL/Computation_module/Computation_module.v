module Computation_module(
    input clk,
    input rst,
    input [7:0] serial_mode_feature_baseaddr,
    input [5:0] systolic_mode_feature_baseaddr,
    input serial_mode_en,
    input Weight_Preloader_en,
    input Feature_Loader_en,

    input custom_mode_en,


    input systolic_mode, // weight perload or feature load
    input [1:0] c_reg_sel, // select c11 or c12 or c21 or c22 to store result
    input [1:0] computation_mode_sel,
    input [7:0] q,
    output serial_mode_done,
    output weight_Preloader_done,
    output feature_Loader_done,

    output custom_mode_done,

    output [5:0] addr,
    output [7:0] c11_sa,
    output [7:0] c12_sa,
    output [7:0] c21_sa,
    output [7:0] c22_sa,

    output [7:0] c11_custom,
    output [7:0] c12_custom,
    output [7:0] c21_custom,
    output [7:0] c22_custom
);

    wire [5:0] addr_0, addr_1,addr_2;
    wire [7:0] q_0;
    wire [7:0] q_1;
    wire [7:0] q_2;
    

    Serial_mode Serial_mode(
        .clk(clk),
        .rst(rst),
        .en(serial_mode_en),
        .feature_baseaddr(serial_mode_feature_baseaddr),
        .q(q_0),

        .addr(addr_0),
        .is_done_o(serial_mode_done),
        .out()
    );

    Systolic_mode Systolic_mode(
  
        .clk(clk),
        .rst(rst),
        .Weight_Preloader_en(Weight_Preloader_en),
        .Feature_Loader_en(Feature_Loader_en),
        .feature_baseaddr(systolic_mode_feature_baseaddr),
        .mode(systolic_mode),
        .c_sel(c_reg_sel),
        .q(q_1),

        .addr(addr_1),
        .is_FL_done_o(feature_Loader_done),
        .is_WL_done_o(weight_Preloader_done),
        .c11(c11_sa),
        .c12(c12_sa),
        .c21(c21_sa),
        .c22(c22_sa)
    );  

    Custom_mode Custom_mode(

        .clk(clk),                  // from fsm
        .rst(rst),                  // from fsm
        .en(custom_mode_en),                   // from fsm
        
        .data_i(q_2),     // from memory
        
        .addr_o(addr_2),     // to memory
        
        .c11(c11_custom),
        .c12(c12_custom),
        .c21(c21_custom),
        .c22(c22_custom),

        .is_done_o(custom_mode_done)   // to fsm
    );
    six_bit_three_to_one_mux_gatelevel_module six_bit_three_to_one_mux(
        .a(addr_0),
        .b(addr_1),
        .c(addr_2),
        .s(computation_mode_sel),
        .out(addr)
    );

    eight_bit_one_to_three_demux_gatelevel_module eight_bit_one_to_three_demux(
        .a(q),
        .sel(computation_mode_sel),
        .out1(q_0),
        .out2(q_1),
        .out3(q_2)
    );
    

endmodule