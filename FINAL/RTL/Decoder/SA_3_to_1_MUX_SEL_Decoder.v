module SA_3_to_1_MUX_SEL_Decoder(
    input [3:0] cnt,
    output wire [1:0] sel
);
    /*
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
    */
    wire not_0,not_1,not_2,not_3;
    wire out_1,out_2,out_3, out_4,out_5,out_6, out_7,out_8;
    wire or_out_1,or_out_2;
    not_gate not_gate_0(.a(cnt[0]), .out(not_0));
    not_gate not_gate_1(.a(cnt[1]), .out(not_1));
    not_gate not_gate_2(.a(cnt[2]), .out(not_2));
    not_gate not_gate_3(.a(cnt[3]), .out(not_3));

    // s1 = 1000 + 01-1;
    four_bit_and_gate four_bit_and_gate_1(.a({cnt[3],not_2,not_1,not_0}), .out(out_1));
    three_bit_and_gate three_bit_and_gate_2(.a({not_3,cnt[2],cnt[0]}), .out(out_2));
    or_gate or_gate_1(.a(out_1),.b(out_2),.out(sel[1]));

    // s0 = 0-10 + 01-0;
    three_bit_and_gate three_bit_and_gate_3(.a({not_3,cnt[1],not_0}), .out(out_3));
    three_bit_and_gate three_bit_and_gate_4(.a({not_3,cnt[2],not_0}), .out(out_4));
    or_gate or_gate_2(.a(out_3),.b(out_4),.out(sel[0]));
endmodule