module SA_feature_address_decoder(
    input [3:0] cnt,
    output reg [5:0] addr
);
    always @(*) begin
        case(cnt)
            4'b0000 : addr = 6'b00_1000; //8
            4'b0001 : addr = 6'b00_0100; //4
            4'b0010 : addr = 6'b00_1001; //9
            4'b0011 : addr = 6'b00_0000; //0
            4'b0100 : addr = 6'b00_0101; //5
            4'b0101 : addr = 6'b00_1010; //10
            4'b0110 : addr = 6'b00_0001; //1
            4'b0111 : addr = 6'b00_0110; //6
            4'b1000 : addr = 6'b00_0010; //2
        endcase
    end

endmodule
