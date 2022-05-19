module tb_eight_bit_signed_subtractor;
    reg [7:0] a;
    reg [7:0] b;
    wire [7:0] out;

    eigth_bit_signed_subtractor inst(
    .a(a),
    .b(b),
    .out(out)
);
    initial begin
        a = 8'b0000_0010;
        b = 8'b0000_0011;

        #20
        a = 8'b0000_0100;
        b = 8'b0000_0110;
        #20
        a = 8'b0000_1000;
        b = 8'b0000_0110;
    end
endmodule