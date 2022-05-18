module Demux_SEL(

    input           clk,
    input           rst,
    input   [3:0]   acc_en,
    output  [7:0]   custom_demux_sel
);

    two_bit_upper two_bit_upper_inst1(
        .clk    (clk), 
        .en     (acc_en[3]), 
        .rst    (rst), 
        .out    (custom_demux_sel[7:6])
    );
    two_bit_upper two_bit_upper_inst2(
        .clk    (clk), 
        .en     (acc_en[2]), 
        .rst    (rst), 
        .out    (custom_demux_sel[5:4])
    );
    two_bit_upper two_bit_upper_inst3(
        .clk    (clk), 
        .en     (acc_en[1]), 
        .rst    (rst), 
        .out    (custom_demux_sel[3:2])
    );
    two_bit_upper two_bit_upper_inst4(
        .clk    (clk), 
        .en     (acc_en[0]), 
        .rst    (rst), 
        .out    (custom_demux_sel[1:0])
    );
    
endmodule