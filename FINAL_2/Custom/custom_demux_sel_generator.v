// generating demux select for selecting alu out value to each feature out acc signal 

module Demux_SEL(

    input           clk,
    input           rst,
    input   [3:0]   buff_use,
    output  [7:0]   custom_demux_sel
);

    // inst two_bit_upper
    two_bit_upper two_bit_upper_inst1(.clk(clk), .en(buff_use[3]), .rst(rst), .out(custom_demux_sel[7:6]));
    two_bit_upper two_bit_upper_inst2(.clk(clk), .en(buff_use[2]), .rst(rst), .out(custom_demux_sel[5:4]));
    two_bit_upper two_bit_upper_inst3(.clk(clk), .en(buff_use[1]), .rst(rst), .out(custom_demux_sel[3:2]));
    two_bit_upper two_bit_upper_inst4(.clk(clk), .en(buff_use[0]), .rst(rst), .out(custom_demux_sel[1:0]));
    
endmodule