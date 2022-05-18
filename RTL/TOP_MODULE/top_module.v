module top_module(
    input clk,
    input [1:0] sw,
    output [3:0] an,
    output [6:0] seg
);  
    wire serial_mode_en;
    wire Weight_Preloader_en;
    wire Feature_Loader_en;
    wire serial_mode_done;
    wire weight_Preloader_done;
    wire feature_Loader_done;
    wire display_done;
    wire rst_computation_module;
    wire rst_display_module;
    wire [7:0] serial_mode_feature_baseaddr;
    wire [5:0] systolic_mode_feature_baseaddr;
    wire [7:0] data;
    wire [7:0] data_o;
    wire [5:0] addr_0;
    wire [5:0] addr_1;
    wire [5:0] addr;
    wire we_1;
    wire we_0;
    wire we;
    wire [7:0] q_o;
    wire [7:0] q;
    wire mem_sel;
    wire systolic_mode;
    wire [1:0] c_reg_sel;
    wire computation_mode_sel;
    wire display_mode_en;
    wire [7:0] c11;
    wire [7:0] c12;
    wire [7:0] c21;
    wire [7:0] c22;

    Controller Controller(
            .clk(clk),
            .rst(sw[0]),
            .start(sw[1]),
            .serial_mode_done(serial_mode_done),
            .weight_Preloader_done(weight_Preloader_done),
            .feature_Loader_done(feature_Loader_done),

            .display_done(display_done),

            .rst_computation_module(rst_computation_module),
            .rst_display_module(rst_display_module),
            .data(data),
            .addr_0(addr_0),
            .we_0(we_0),

            .mem_sel(mem_sel), 
            .serial_mode_feature_baseaddr(serial_mode_feature_baseaddr),
            .systolic_mode_feature_baseaddr(systolic_mode_feature_baseaddr),
            .serial_mode_en(serial_mode_en),
            .Weight_Preloader_en(Weight_Preloader_en),
            .Feature_Loader_en(Feature_Loader_en),
            .systolic_mode(systolic_mode),
            .c_reg_sel(c_reg_sel), 
            .computation_mode_sel(computation_mode_sel),
            .display_mode_en(display_mode_en)
        );
    Computation_module Computation_module(
        .clk(clk),
        .rst(rst_computation_module),
        .serial_mode_feature_baseaddr(serial_mode_feature_baseaddr),
        .systolic_mode_feature_baseaddr(systolic_mode_feature_baseaddr),
        .serial_mode_en(serial_mode_en),
        .Weight_Preloader_en(Weight_Preloader_en),
        .Feature_Loader_en(Feature_Loader_en),
        .systolic_mode(systolic_mode), // weight perload or feature load
        .c_reg_sel(c_reg_sel), // select c11 or c12 or c21 or c22 to store result
        .computation_mode_sel(computation_mode_sel),
        .q(q),
        .serial_mode_done(serial_mode_done),
        .weight_Preloader_done(weight_Preloader_done),
        .feature_Loader_done(feature_Loader_done),
        .addr(addr_1),
        .we(we_1),
        .c11(c11),
        .c12(c12),
        .c21(c21),
        .c22(c22)
    );
    single_port_ram ram (
        .data(data_o),
        .addr(addr),
        .we(we), 
        .clk(clk),
        .q(q_o)
    );

    memory_interface memory_interface(
        .data_i(data),
        .we_0(we_0),
        .we_1(we_1),
        .sel(mem_sel),
        .addr_0(addr_0),
        .addr_1(addr_1),
        .q_i(q_o),

        .addr_o(addr),
        .we_o(we),
        .data_o(data_o),
        .q_o(q)
    );

    Display_module display_module(
        .clk(clk),
        .rst(rst_display_module),
        .reg_en(display_mode_en),
        .c11(c11),
        .c12(c12),
        .c21(c21),
        .c22(c22),

        .is_done_o(display_done),
        .Anode_Activate(an),
        .LED_out(seg)
    );
endmodule