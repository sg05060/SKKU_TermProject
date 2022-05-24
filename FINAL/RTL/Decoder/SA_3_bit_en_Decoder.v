module SA_3_bit_en_Decoder(
    input [3:0] cnt,
    output wire [2:0] en
);
    /*
    always @(*) begin
        case(cnt)
            4'b0000 : en = 3'b111;
            4'b0001 : en = 3'b101;
            4'b0010 : en = 3'b010;
            4'b0011 : en = 3'b100;
            4'b0100 : en = 3'b010;
            4'b0101 : en = 3'b001;
            4'b0110 : en = 3'b110;
            4'b0111 : en = 3'b001;
            4'b1000 : en = 3'b111;
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

    // en2 = 0110 + 00-1 + -000;
    four_bit_and_gate four_bit_and_gate_1(.a({not_3,cnt[2:1],not_0}), .out(out_1));
    three_bit_and_gate three_bit_and_gate_1(.a({not_3,not_2,cnt[0]}), .out(out_2));
    three_bit_and_gate three_bit_and_gate_2(.a({not_2,not_1,not_0}), .out(out_3));
    or_gate or_gate_1(.a(out_1),.b(out_2),.out(or_out_1));
    or_gate or_gate_2(.a(out_3),.b(or_out_1),.out(en[2]));

    // en1 = 0--0 + -000;
    three_bit_and_gate three_bit_and_gate_3(.a({not_2,not_1,not_0}), .out(out_4));
    and_gate and_gate_1(.a(not_3), .b(not_0), .out(out_5));
    or_gate or_gate_3(.a(out_4),.b(out_5),.out(en[1]));

    // en0 = 01-1 + 000- + -000;
    four_bit_and_gate four_bit_and_gate_2(.a({not_3,cnt[2],cnt[0]}), .out(out_5));
    three_bit_and_gate three_bit_and_gate_4(.a({not_3,not_2,not_1}), .out(out_6));
    three_bit_and_gate three_bit_and_gate_5(.a({not_2,not_1,not_0}), .out(out_7));
    or_gate or_gate_4(.a(out_5),.b(out_6),.out(or_out_2));
    or_gate or_gate_5(.a(out_7),.b(or_out_2),.out(en[0]));

endmodule