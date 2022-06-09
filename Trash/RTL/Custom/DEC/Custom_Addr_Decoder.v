module Custom_Addr_Decoder(
    input [4:0] cnt,            // stage 27 -> 2^5 = 32
    output reg [5:0] addr       // 
);
    always @(*) begin
        case(cnt)
            5'b0_0000 : addr = 6'b00_0000;
            5'b0_0001 : addr = 6'b00_0001;
            5'b0_0010 : addr = 6'b00_0010;
            5'b0_0011 : addr = 6'b00_0011;
            5'b0_0100 : addr = 6'b00_1001;
            5'b0_0101 : addr = 6'b00_1010;
            5'b0_0110 : addr = 6'b00_1011;
            5'b0_0111 : addr = 6'b00_1100;
            5'b0_1000 : addr = 6'b00_1101;
            5'b0_1001 : addr = 6'b00_1110;
            5'b0_1010 : addr = 6'b00_0100;
            5'b0_1011 : addr = 6'b00_1111;
            5'b0_1100 : addr = 6'b00_0101;
            5'b0_1101 : addr = 6'b01_0000;
            5'b0_1110 : addr = 6'b00_0110;
            5'b0_1111 : addr = 6'b01_0001;
            5'b1_0000 : addr = 6'b01_0010;
            5'b1_0001 : addr = 6'b00_0111;
            5'b1_0010 : addr = 6'b01_0011;
            5'b1_0011 : addr = 6'b00_1000;
            5'b1_0100 : addr = 6'b01_0100;
            5'b1_0101 : addr = 6'b01_0101;
            5'b1_0110 : addr = 6'b01_0110;
            5'b1_0111 : addr = 6'b01_0111;
            5'b1_1000 : addr = 6'b01_1000;
            default   : addr = 6'b00_0000;
        endcase
    end
endmodule