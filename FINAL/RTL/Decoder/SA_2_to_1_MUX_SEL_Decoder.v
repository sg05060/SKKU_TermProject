module SA_2_to_1_MUX_SEL_Decoder(
    input [3:0] cnt,
    output wire [2:0] sel
);
    //    4'b0000 : sel = 3'b011;
    //    4'b0001 : sel = 3'b011;
    //    4'b0010 : sel = 3'b000;
    //    4'b0011 : sel = 3'b000;
    //    4'b0100 : sel = 3'b000;
    //    4'b0101 : sel = 3'b100;
    //    4'b0110 : sel = 3'b101;
    //    4'b0111 : sel = 3'b010;
    //    4'b1000 : sel = 3'b110;
    
    wire not_0,not_1,not_2,not_3;
    wire out_1,out_2,out_3, out_4,out_5,out_6, out_7,out_8;
    wire or_out_1,or_out_2;
    not_gate not_gate_0(.a(cnt[0]), .out(not_0));
    not_gate not_gate_1(.a(cnt[1]), .out(not_1));
    not_gate not_gate_2(.a(cnt[2]), .out(not_2));
    not_gate not_gate_3(.a(cnt[3]), .out(not_3));

    // s2 = 1000 + 0110 + 0101
    four_bit_and_gate four_bit_and_gate_1(.a({cnt[3],not_2,not_1,not_0}), .out(out_1));
    four_bit_and_gate four_bit_and_gate_2(.a({not_3,cnt[2],cnt[1],not_0}), .out(out_2));
    four_bit_and_gate four_bit_and_gate_3(.a({not_3,cnt[2],not_1,cnt[0]}), .out(out_3));
    or_gate or_gate_1(.a(out_1),.b(out_2),.out(or_out_1));
    or_gate or_gate_2(.a(out_3),.b(or_out_1),.out(sel[2]));

    // s1 = 0111 + 1000 + 000-;
    four_bit_and_gate four_bit_and_gate_4(.a({not_3,cnt[2:0]}), .out(out_4));
    four_bit_and_gate four_bit_and_gate_5(.a({cnt[3],not_2,not_1,not_0}), .out(out_5));
    three_bit_and_gate three_bit_and_gate_1(.a({not_3,not_2,not_1}), .out(out_6));
    or_gate or_gate_3(.a(out_4),.b(out_5),.out(or_out_2));
    or_gate or_gate_4(.a(out_6),.b(or_out_2),.out(sel[1]));

    // s0 = 0110 + 000-;
    four_bit_and_gate four_bit_and_gate_6(.a({not_3,cnt[2],cnt[1],not_0}), .out(out_7));
    three_bit_and_gate three_bit_and_gate_2(.a({not_3,not_2,not_1}), .out(out_8));
    or_gate or_gate_5(.a(out_7),.b(out_8),.out(sel[0]));
    
endmodule