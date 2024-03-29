//////////////////////////////////////////////////////////////////////////////////
// Company:			SungKyunKwan University Electronic Electrical Engineering
// Engineer:		sg05060(박상현), gju06051(최보열), skklnventor(장재성), nakyung0305(홍나경)
//
// Create Date:		2022/05/19
// Design Name: 	Computations in deep neural networks
// Module Name: 	top_module
// Project Name:	Logic Design Laboratory(ICE2005) Term-Project
// Target Devices:	FPGA Starter Kit Ⅲ Board
// Tool Versions:	Vivado-Simulator(2021.2)
// Description: 	This modulel is top hierachy of all module in Term-Project module, all other module in this project repo,
//					under in this indent information 
//              
// Dependencies:	Vivado(2021.2)
//
// Revision:        Revision 1.00 - using decoder with behavioral code(2022.05.19)
//                  Revision 1.01 - using decoder change gatelevel, structural level(2022.05.26)
//                  Revision 1.02 - modify some module name, variable name for readability(2022.06.01)
//
// Additional Comments: This project is covered in SKKU-University Logic-Design-Laboratory(ICE2005)' pf. Yunho Oh
//                      If you need any use of this project, please contact to this class pf and repo owner
//                      pf Yunho Oh : https://yunho-oh.github.io/
//
//////////////////////////////////////////////////////////////////////////////////

module top_module(
    input           clk,
    input   [1:0]   sw,
    output  [3:0]   an,
    output  [6:0]   seg
);  
    // enable signal
    wire serial_mode_en;
    wire Weight_Preloader_en;
    wire Feature_Loader_en;
    wire custom_mode_en;
    
    // done signal
    wire serial_mode_done;
    wire weight_Preloader_done;
    wire feature_Loader_done;
    wire custom_mode_done;
    wire display_done;
    
    // reset signal
    wire rst_computation_module;
    wire rst_display_module;
    
    // memory control & data signal
    wire [7:0] serial_mode_feature_baseaddr;
    wire [5:0] systolic_mode_feature_baseaddr;
    wire [7:0] data;
    wire [7:0] data_o;
    wire [5:0] addr_0;
    wire [5:0] addr_1;
    wire [5:0] addr;
    wire we;
    wire [7:0] q_o;
    wire [7:0] q;
    wire mem_sel;
    
    // mode selection signal
    wire systolic_mode;
    wire [1:0] c_reg_sel;
    wire [1:0] computation_mode_sel;
    wire display_mode_reg_en;
    
    // feature out signal
    wire [7:0] c11_sa;
    wire [7:0] c12_sa;
    wire [7:0] c21_sa;
    wire [7:0] c22_sa;
    wire [7:0] c11_custom;
    wire [7:0] c12_custom;
    wire [7:0] c21_custom;
    wire [7:0] c22_custom;


    Controller Controller(
        .clk(clk),
        .rst(sw[0]),
        .start(sw[1]),
        
        // done signal
        .serial_mode_done(serial_mode_done),
        .weight_Preloader_done(weight_Preloader_done),
        .feature_Loader_done(feature_Loader_done),
        .custom_mode_done(custom_mode_done),
        .display_done(display_done),

        .rst_computation_module(rst_computation_module),
        .rst_display_module(rst_display_module),
        .data(data),
        .addr_0(addr_0),

        .mem_sel(mem_sel), 
        .serial_mode_feature_baseaddr(serial_mode_feature_baseaddr),
        .systolic_mode_feature_baseaddr(systolic_mode_feature_baseaddr),
        
        // enable and datapass select signal 
        .serial_mode_en(serial_mode_en),
        .Weight_Preloader_en(Weight_Preloader_en),
        .Feature_Loader_en(Feature_Loader_en),
        .custom_mode_en(custom_mode_en),
        .systolic_mode(systolic_mode),
        .c_reg_sel(c_reg_sel), 
        .computation_mode_sel(computation_mode_sel),
        .display_mode_reg_en(display_mode_reg_en)
    );
    
    
    Computation_module Computation_module(
        .clk(clk),
        .rst(rst_computation_module),
        .serial_mode_feature_baseaddr(serial_mode_feature_baseaddr),
        .systolic_mode_feature_baseaddr(systolic_mode_feature_baseaddr),
        
        // module enable signal 
        .serial_mode_en(serial_mode_en),
        .Weight_Preloader_en(Weight_Preloader_en),
        .Feature_Loader_en(Feature_Loader_en),
        .custom_mode_en(custom_mode_en),
        .systolic_mode(systolic_mode),  // systolic active enable signal
                                        // if 1'b0 weight preloader on, feature preloader off 
                                        // if 1'b1 feature preloader on, weight preloader off
        
        // select c11 or c12 or c21 or c22 to store result
        .c_reg_sel(c_reg_sel),          
        
        // selecting computation mode
        .computation_mode_sel(computation_mode_sel),
                                                        // 2'b00 : serial
                                                        // 2'b01 : systolic
                                                        // 2'b10 : custom
        
        // data from memory
        .q(q),
        
        // module done signal
        .serial_mode_done(serial_mode_done),
        .weight_Preloader_done(weight_Preloader_done),
        .feature_Loader_done(feature_Loader_done),
        .custom_mode_done(custom_mode_done),
        
        // address from computational module 
        .addr(addr_1),
        
        // output feature_map from systolic and custom module
        .c11_sa(c11_sa),
        .c12_sa(c12_sa),
        .c21_sa(c21_sa),
        .c22_sa(c22_sa),
        .c11_custom(c11_custom),
        .c12_custom(c12_custom),
        .c21_custom(c21_custom),
        .c22_custom(c22_custom)
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
        .sel(mem_sel),
        .addr_0(addr_0),    // address for initializing data in memory
        .addr_1(addr_1),    // address of data using computational module
        .q_i(q_o),          // initialize data from controller to memory

        .addr_o(addr),      // output address selecting(initialize or computation req)
        .we_o(we),          // write enable signal
        .data_o(data_o),    // data from memory to computation module
        .q_o(q)             // initialize data from controller to memory
    );


    Display_module display_module(
        .clock_100Mhz(clk),
        .reset(rst_display_module),
        .reg_en(display_mode_reg_en),
        .c11_sa(c11_sa),
        .c12_sa(c12_sa),
        .c21_sa(c21_sa),
        .c22_sa(c22_sa),
        .c11_custom(c11_custom),
        .c12_custom(c12_custom),
        .c21_custom(c21_custom),
        .c22_custom(c22_custom),

        .is_done_o(display_done),
        .Anode_Activate(an),
        .LED_out(seg)
    );
endmodule