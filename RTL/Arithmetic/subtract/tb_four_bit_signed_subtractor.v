module tb_four_bit_signed_subtractor;
    reg [3:0] a;
    reg [3:0] b;
    reg cin;
    wire [3:0] out;
    wire cout;

    four_bit_signed_subtractor inst(
        .a(a),
        .b(b),
        .cin(cin),
        .out(out),
        .cout(cout)
    );  
    initial begin
        cin = 1'b1;
        a = 4'b0010;
        b = 4'b0011;

        #20
        a = 4'b0100;
        b = 4'b0110;
    end
endmodule