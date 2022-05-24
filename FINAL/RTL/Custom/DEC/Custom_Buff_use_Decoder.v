module Custom_Buff_use_Decoder(
    input       [4:0]   cnt,
    output reg  [3:0]   buff_use
);

    always @(*) begin
        case(cnt)
            5'b0_0000 : buff_use = 4'b0000;
            5'b0_0001 : buff_use = 4'b0000;
            5'b0_0010 : buff_use = 4'b0000;
            5'b0_0011 : buff_use = 4'b0000;
            5'b0_0100 : buff_use = 4'b0000;
            5'b0_0101 : buff_use = 4'b1000;
            5'b0_0110 : buff_use = 4'b1100;
            5'b0_0111 : buff_use = 4'b0110;
            5'b0_1000 : buff_use = 4'b0010;
            5'b0_1001 : buff_use = 4'b1001;
            5'b0_1010 : buff_use = 4'b1101;
            5'b0_1011 : buff_use = 4'b1000;
            5'b0_1100 : buff_use = 4'b1110;
            5'b0_1101 : buff_use = 4'b0100;
            5'b0_1110 : buff_use = 4'b0110;
            5'b0_1111 : buff_use = 4'b0000;
            5'b1_0000 : buff_use = 4'b0011;
            5'b1_0001 : buff_use = 4'b1011;
            5'b1_0010 : buff_use = 4'b0001;
            5'b1_0011 : buff_use = 4'b1101;
            5'b1_0100 : buff_use = 4'b1000;
            5'b1_0101 : buff_use = 4'b1100;
            5'b1_0110 : buff_use = 4'b0010;
            5'b1_0111 : buff_use = 4'b0011;
            5'b1_1000 : buff_use = 4'b1001;
            5'b1_1001 : buff_use = 4'b1000;
            default   : buff_use = 4'b0000;
        endcase
    end

    // binary output expression
    // 01001 0001
    // 01100 1000
    // 10101 0100
    // 00111 0110
    // 11000 1001
    // 00110 1100
    // 10011 1100
    // 01-00 0010
    // 10-11 0001
    // 1011- 0010
    // 01010 1101
    // 010-1 1000
    // 1000- 0010
    // 0110- 0100
    // 1-001 1000
    // 011-0 0110
    // -0101 1000
    // 1010- 1000
    // 100-- 0001
    
    // boolean expression
    // buff_use[3] = 01100 | 11000 | 00110 | 10011 | 01010 | 010-1 | 1-001 | -0101 | 1010-
    // buff_use[2] = 10101 | 00111 | 00110 | 10011 | 01010 | 0110- | 011-0
    // buff_use[1] = 00111 | 01-00 | 1011- | 1000- | 011-0 
    // buff_use[0] = 01001 | 11000 | 10-11 | 01010 | 100--
    
endmodule