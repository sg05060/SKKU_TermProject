module Custom_ACC_en_Decoder(
    input [4:0] cnt,            // stage 27 -> 2^5 = 32
    output reg [3:0] acc_en     // 
);
    always @(*) begin
        case(cnt)
            5'b0_0000 : acc_en = 4'b0000;
            5'b0_0001 : acc_en = 4'b0000;
            5'b0_0010 : acc_en = 4'b0000;
            5'b0_0011 : acc_en = 4'b0000;
            5'b0_0100 : acc_en = 4'b0000;
            5'b0_0101 : acc_en = 4'b1000;
            5'b0_0110 : acc_en = 4'b1100;
            5'b0_0111 : acc_en = 4'b1100;
            5'b0_1000 : acc_en = 4'b0100;
            5'b0_1001 : acc_en = 4'b1010;
            5'b0_1010 : acc_en = 4'b0111;
            5'b0_1011 : acc_en = 4'b1000;
            5'b0_1100 : acc_en = 4'b0111;
            5'b0_1101 : acc_en = 4'b1000;
            5'b0_1110 : acc_en = 4'b0101;
            5'b0_1111 : acc_en = 4'b0000;
            5'b1_0000 : acc_en = 4'b1010;
            5'b1_0001 : acc_en = 4'b0111;
            5'b1_0010 : acc_en = 4'b1000;
            5'b1_0011 : acc_en = 4'b0111;
            5'b1_0100 : acc_en = 4'b1000;
            5'b1_0101 : acc_en = 4'b0101;
            5'b1_0110 : acc_en = 4'b0010;
            5'b1_0111 : acc_en = 4'b0011;
            5'b1_1000 : acc_en = 4'b0011;
            5'b1_1001 : acc_en = 4'b0001;
            default   : acc_en = 4'b0000;
        endcase
    end
endmodule