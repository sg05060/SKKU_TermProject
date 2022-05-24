module Custom_Feature_Weight_en_Decoder(
    input [4:0] cnt,                
    // output reg [3:0] buff_en     // this line is for behavioral test
);

    // Binary output expression
    // 10000 0010
    // 01111 0001
    // 011-1 0010
    // 10101 0010
    // 00011 0001
    // 01011 0110
    // 00110 0100
    // 10100 1100
    // 10010 1101
    // 10-11 1000
    // 0100- 0001
    // 1000- 0001
    // 0110- 0100
    // 1011- 0001
    // -0110 0010
    // 00-10 0010
    // 0010- 1000
    // --000 1000
    // 010-- 1000
    // 0--01 0100
    // 0-11- 0010
    
    // Boolean expression
    // buff_en[3] = 10100 | 10010 | 10-11 | 0010- | --000 | 010-- 
    // buff_en[2] = 01011 | 00110 | 10100 | 10010 | 0110- | 0--01
    // buff_en[1] = 10000 | 011-1 | 10101 | 01011 | -0110 | 00-10 | 0-11- 
    // buff_en[0] = 01111 | 00011 | 10010 | 0100- | 1000- | 1011-
    
    // behavioral logic(not use)
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