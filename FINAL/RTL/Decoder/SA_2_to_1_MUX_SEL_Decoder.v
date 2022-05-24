module SA_2_to_1_MUX_SEL_Decoder(
    input [3:0] cnt,
    output reg [2:0] sel
);
    always @(*) begin
        case(cnt)
            4'b0000 : sel = 3'b011;
            4'b0001 : sel = 3'b011;
            4'b0010 : sel = 3'b000;
            4'b0011 : sel = 3'b000;
            4'b0100 : sel = 3'b000;
            4'b0101 : sel = 3'b100;
            4'b0110 : sel = 3'b101;
            4'b0111 : sel = 3'b010;
            4'b1000 : sel = 3'b110;
        endcase
    end
    // s2 = 1000 + 0110 + 0101
    // s1 = 0111 + 1000 + 000-;
    // s0 = 0110 + 000-;
endmodule