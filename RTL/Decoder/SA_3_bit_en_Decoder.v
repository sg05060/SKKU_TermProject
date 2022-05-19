module SA_3_bit_en_Decoder(
    input [3:0] cnt,
    output reg [2:0] en
);
    always @(*) begin
        case(cnt)
            4'b0000 : en = 3'b111;
            4'b0001 : en = 3'b101;
            4'b0010 : en = 3'b010;
            4'b0011 : en = 3'b100;
            4'b0100 : en = 3'b010;
            4'b0101 : en = 3'b001;
            4'b0110 : en = 3'b110;
            4'b0111 : en = 3'b001;
            4'b1000 : en = 3'b111;
        endcase
    end
endmodule