module Custom_Feature_Weight_en_Decoder(
    input [4:0] cnt,                // stage 27 -> 2^5 = 32
    output reg [3:0] buff_en        //
);
    always @(*) begin
        case(cnt)
            5'b0_0000 : buff_en = 4'b1000;
            5'b0_0001 : buff_en = 4'b0100;
            5'b0_0010 : buff_en = 4'b0010;
            5'b0_0011 : buff_en = 4'b0001;
            5'b0_0100 : buff_en = 4'b1000;
            5'b0_0101 : buff_en = 4'b1100;
            5'b0_0110 : buff_en = 4'b0110;
            5'b0_0111 : buff_en = 4'b0010;
            5'b0_1000 : buff_en = 4'b1001;
            5'b0_1001 : buff_en = 4'b1101;
            5'b0_1010 : buff_en = 4'b1000;
            5'b0_1011 : buff_en = 4'b1110;
            5'b0_1100 : buff_en = 4'b0100;
            5'b0_1101 : buff_en = 4'b0110;
            5'b0_1110 : buff_en = 4'b0010;
            5'b0_1111 : buff_en = 4'b0011;
            5'b1_0000 : buff_en = 4'b1011;
            5'b1_0001 : buff_en = 4'b0001;
            5'b1_0010 : buff_en = 4'b1101;
            5'b1_0011 : buff_en = 4'b1000;
            5'b1_0100 : buff_en = 4'b1100;
            5'b1_0101 : buff_en = 4'b0010;
            5'b1_0110 : buff_en = 4'b0011;
            5'b1_0111 : buff_en = 4'b1001;
            5'b1_1000 : buff_en = 4'b1000;
            default   : buff_en = 4'b0000;
        endcase
    end
endmodule