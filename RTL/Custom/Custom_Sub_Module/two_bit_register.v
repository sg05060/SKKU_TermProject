module two_bit_register_module(

    input   [1:0]   in, 
    input           clk, 
    input           rst, 
    output  [1:0]   out
);

    one_bit_register_behavioral_module one_bit_register_inst_0(in[0], clk, rst, out[0]);
    one_bit_register_behavioral_module one_bit_register_inst_1(in[1], clk, rst, out[1]);

endmodule



