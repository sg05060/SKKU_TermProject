module SA_3_to_1_MUX_SEL_Decoder(
    input [3:0] cnt,
    output reg [1:0] sel
);
    always @(*) begin
        case(cnt)
            4'b0000 : sel = 2'b00;
            4'b0001 : sel = 2'b00;
            4'b0010 : sel = 2'b01;
            4'b0011 : sel = 2'b00;
            4'b0100 : sel = 2'b01;
            4'b0101 : sel = 2'b10;
            4'b0110 : sel = 2'b01;
            4'b0111 : sel = 2'b10;
            4'b1000 : sel = 2'b10;
        endcase
    end
endmodule