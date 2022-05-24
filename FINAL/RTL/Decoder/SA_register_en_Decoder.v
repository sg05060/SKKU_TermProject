module SA_register_en_Decoder(
    input [3:0] cnt,
    output wire en
);  
    /*
    always @(*) begin
        case(cnt)
            4'b0000 : en = 1'b1;
            4'b0001 : en = 1'b0;
            4'b0010 : en = 1'b1;
            4'b0011 : en = 1'b0;
            4'b0100 : en = 1'b0;
            4'b0101 : en = 1'b1;
            4'b0110 : en = 1'b0;
            4'b0111 : en = 1'b1;
            4'b1000 : en = 1'b1;
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

    // en = -000 + 01-1 + 00-0;
    three_bit_and_gate three_bit_and_gate_1(.a({not_2,not_1,not_0}), .out(out_1));
    three_bit_and_gate three_bit_and_gate_2(.a({not_3,cnt[2],cnt[0]}), .out(out_2));
    three_bit_and_gate three_bit_and_gate_3(.a({not_3,not_2,not_0}), .out(out_3));
    or_gate or_gate_1(.a(out_1),.b(out_2),.out(or_out_1));
    or_gate or_gate_2(.a(out_3),.b(or_out_1),.out(en));
endmodule