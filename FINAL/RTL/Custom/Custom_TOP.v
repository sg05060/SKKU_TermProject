module Custom_TOP(

    // basic signal
    input clk,
    input rst,
    
    // Controll signal
    input   [7:0]   sel_demux,
    input   [3:0]   acc_en,
    input   [3:0]   weight_en,
    input   [3:0]   feature_en,
    input   [3:0]   buff_mux_sel,

    // mem data
    input   [7:0]   data_in,
    
    // convolution out feature map
    output  [7:0]   c11,
    output  [7:0]   c12,
    output  [7:0]   c21,
    output  [7:0]   c22
    
);

    // buff out to mux port
    wire    [7:0]   alu_out_1, alu_out_2, alu_out_3, alu_out_4;
    wire    [7:0]   mux_out_1, mux_out_2, mux_out_3, mux_out_4;
    
    // demux to acc port
    wire    [7:0]   buff1_1, buff1_2, buff1_3, buff1_4;
    wire    [7:0]   buff2_1, buff2_2, buff2_3, buff2_4;
    wire    [7:0]   buff3_1, buff3_2, buff3_3, buff3_4;
    wire    [7:0]   buff4_1, buff4_2, buff4_3, buff4_4;


    // inst buff_alu
    Custom_Buff_ALU Custom_Buff_ALU_1( .clk(clk), .rst(rst), .feature_en(feature_en[3]), .weight_en(weight_en[3]), .data_in(data_in), .mul_out(alu_out_1));
    Custom_Buff_ALU Custom_Buff_ALU_2( .clk(clk), .rst(rst), .feature_en(feature_en[2]), .weight_en(weight_en[2]), .data_in(data_in), .mul_out(alu_out_2));
    Custom_Buff_ALU Custom_Buff_ALU_3( .clk(clk), .rst(rst), .feature_en(feature_en[1]), .weight_en(weight_en[1]), .data_in(data_in), .mul_out(alu_out_3));
    Custom_Buff_ALU Custom_Buff_ALU_4( .clk(clk), .rst(rst), .feature_en(feature_en[0]), .weight_en(weight_en[0]), .data_in(data_in), .mul_out(alu_out_4));
    
    
    // inst mux
    eight_bit_two_to_one_mux_gatelevel_module eight_bit_2to1_mux_1(.a(8'b0), .b(alu_out_1), .s(buff_mux_sel[3]), .out(mux_out_1));
    eight_bit_two_to_one_mux_gatelevel_module eight_bit_2to1_mux_2(.a(8'b0), .b(alu_out_2), .s(buff_mux_sel[2]), .out(mux_out_2));
    eight_bit_two_to_one_mux_gatelevel_module eight_bit_2to1_mux_3(.a(8'b0), .b(alu_out_3), .s(buff_mux_sel[1]), .out(mux_out_3));
    eight_bit_two_to_one_mux_gatelevel_module eight_bit_2to1_mux_4(.a(8'b0), .b(alu_out_4), .s(buff_mux_sel[0]), .out(mux_out_4));
    
    
    // inst demux
    eight_bit_one_to_four_demux_gatelevel_module eight_bit_demux_inst1(.a(mux_out_1), .s(sel_demux[7:6]), .out1(buff1_1), .out2(buff1_2), .out3(buff1_3), .out4(buff1_4));
    eight_bit_one_to_four_demux_gatelevel_module eight_bit_demux_inst2(.a(mux_out_2), .s(sel_demux[5:4]), .out1(buff2_1), .out2(buff2_2), .out3(buff2_3), .out4(buff2_4));
    eight_bit_one_to_four_demux_gatelevel_module eight_bit_demux_inst3(.a(mux_out_3), .s(sel_demux[3:2]), .out1(buff3_1), .out2(buff3_2), .out3(buff3_3), .out4(buff3_4));
    eight_bit_one_to_four_demux_gatelevel_module eight_bit_demux_inst4(.a(mux_out_4), .s(sel_demux[1:0]), .out1(buff4_1), .out2(buff4_2), .out3(buff4_3), .out4(buff4_4));
    
    
    // Inst Custom ACC
    custom_acc custom_acc_inst1(.in_1(buff1_1), .in_2(buff2_1), .in_3(buff3_1), .in_4(buff4_1),  .clk(clk), .rst(rst), .en(acc_en[3]), .out(c11));
    custom_acc custom_acc_inst2(.in_1(buff1_2), .in_2(buff2_2), .in_3(buff3_2), .in_4(buff4_2),  .clk(clk), .rst(rst), .en(acc_en[2]), .out(c12));
    custom_acc custom_acc_inst3(.in_1(buff1_3), .in_2(buff2_3), .in_3(buff3_3), .in_4(buff4_3),  .clk(clk), .rst(rst), .en(acc_en[1]), .out(c21));
    custom_acc custom_acc_inst4(.in_1(buff1_4), .in_2(buff2_4), .in_3(buff3_4), .in_4(buff4_4),  .clk(clk), .rst(rst), .en(acc_en[0]), .out(c22));
    
    
endmodule