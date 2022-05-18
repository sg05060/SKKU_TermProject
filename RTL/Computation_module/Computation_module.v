module Computation_module(
    input clk,
    input rst,
    input [7:0] serial_mode_feature_baseaddr,
    input [5:0] systolic_mode_feature_baseaddr,
    input serial_mode_en,
    input Weight_Preloader_en,
    input Feature_Loader_en,
    input systolic_mode, // weight perload or feature load
    input [1:0] c_reg_sel, // select c11 or c12 or c21 or c22 to store result
    input computation_mode_sel,
    input [7:0] q,
    output serial_mode_done,
    output weight_Preloader_done,
    output feature_Loader_done,
    output [5:0] addr,
    output we,
    output [7:0] c11,
    output [7:0] c12,
    output [7:0] c21,
    output [7:0] c22
);

    wire [5:0] addr_0, addr_1,addr_2;
    wire we_0, we_1,we_2;
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
        .we(we_0),
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
        .we(we_1),
        .is_FL_done_o(feature_Loader_done),
        .is_WL_done_o(weight_Preloader_done),
        .c11(c11),
        .c12(c12),
        .c21(c21),
        .c22(c22)
    );  

    six_bit_two_to_one_mux_gatelevel_module six_bit_two_to_one_mux(
        .a(addr_0),
        .b(addr_1),
        .s(computation_mode_sel),
        .out(addr)
    );

    two_to_one_mux_gatelevel_module two_to_one_mux(
	    .a(we_0), 
        .b(we_1),
	    .s(computation_mode_sel),	
	    .out(we)
    );

    eight_bit_one_to_two_mux_gatelevel_module eight_bit_one_to_two_mux(
        .a(q),
        .s(computation_mode_sel),
        .out1(q_0),
        .out2(q_1)
    );
    

endmodule