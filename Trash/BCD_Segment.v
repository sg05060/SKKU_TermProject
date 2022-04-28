module BCD_Sevent_Segment(
    input [3:0] num,        // num 0~9 -> 4bit need
    output reg [6:0] disp   // 7anode  -> 7bit need
);

    always @(*) begin
        case(num)
            'd0: disp = 7'b0000001;
            'd1: disp = 7'b1001111;
            'd2: disp = 7'b0010010;
            'd3: disp = 7'b0000110;
            'd4: disp = 7'b0001100;
            'd5: disp = 7'b0100100;
            'd6: disp = 7'b0100000;
            'd7: disp = 7'b0001111;
            'd8: disp = 7'b0000000;
            'd9: disp = 7'b0000100;
            default  : disp = 7'b0;
        endcase
    end
endmodule
