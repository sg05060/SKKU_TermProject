module Top_Systolic_mode(
    input clk,
    input rst,
    input Weight_Preloader_en,
    input Feature_Loader_en,
    input [5:0] feature_baseaddr,
    input systolic_mode,
    input [2:0] c_reg_sel,

    output is_FL_done_o,
    output is_WL_done_o,
    output [7:0] c11,
    output [7:0] c12,
    output [7:0] c21,
    output [7:0] c22
);
    wire [5:0] addr;
    wire [7:0] q;
    Systolic_mode Systolic_mode(
        .clk(clk),
        .rst(rst),
        .Weight_Preloader_en(Weight_Preloader_en),
        .Feature_Loader_en(Feature_Loader_en),
        .feature_baseaddr(feature_baseaddr),
        .mode(systolic_mode),
        .c_sel(c_reg_sel),
        .q(q),
        .addr(addr),
        .is_FL_done_o(is_FL_done_o),
        .is_WL_done_o(is_WL_done_o),
        .c11(c11),
        .c12(c12),
        .c21(c21),
        .c22(c22)
    );
    single_port_ram ram(
        .data(),
        .addr(addr),
        .we(1'b0), 
        .clk(clk),
        .q(q)
    );
endmodule