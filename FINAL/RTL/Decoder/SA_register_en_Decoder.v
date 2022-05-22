module SA_register_en_Decoder(
    input [3:0] cnt,
    output reg en
);
    always @(*) begin
        case(cnt)
            4'b0000 : en = 1'b1;
            4'b0001 : en = 1'b0;
            4'b0010 : en = 1'b1;
            4'b0011 : en = 1'b0;
            4'b0100 : en = 1'b0;
            4'b0101 : en = 1'b1;
            4'b0110 : en = 1'b0;
            4'b0111 : en = 1'b1;
            4'b1000 : en = 1'b1;
        endcase
    end
endmodule