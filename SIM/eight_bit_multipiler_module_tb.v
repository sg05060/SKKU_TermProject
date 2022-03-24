module eight_bit_multipiler_module_tb;
    reg [7:0] a;
    reg [7:0] b;
    wire [15:0] out;

    eight_bit_multipiler_module ISNT_0 (
        .a(a),
        .b(b),
        .out(out)
    );

    initial begin
        a = 0;
        b = 0;

        #10
            a = 8'b0000_0101;
            b = 8'b1101_0110;
        #10
            a = 8'b1010_1101;
            b = 8'b0010_1001;
    end
endmodule