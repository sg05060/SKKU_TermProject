module SA_weight_address_decoder(
    input [3:0] cnt,
    output wire [5:0] addr
);  

    //  4'b0000 : addr = 6'b00_0000; //0
    //  4'b0001 : addr = 6'b00_0011; //3
    //  4'b0010 : addr = 6'b00_0110; //6
    //  4'b0011 : addr = 6'b00_0001; //1
    //  4'b0100 : addr = 6'b00_0100; //4
    //  4'b0101 : addr = 6'b00_0111; //7
    //  4'b0110 : addr = 6'b00_0010; //2
    //  4'b0111 : addr = 6'b00_0101; //5
    //  4'b1000 : addr = 6'b00_1000; //8

    wire not_0,not_1,not_2,not_3;
    wire out_1,out_2,out_3, out_4,out_5,out_6, out_7,out_8,out_9,out_10;
    wire or_out_1,or_out_2;
    not_gate not_gate_0(.a(cnt[0]), .out(not_0));
    not_gate not_gate_1(.a(cnt[1]), .out(not_1));
    not_gate not_gate_2(.a(cnt[2]), .out(not_2));
    not_gate not_gate_3(.a(cnt[3]), .out(not_3));

    // a5 = 1'b0;
    // a4 = 1'b0;
    assign addr[5:4] = 2'b00;

    // a3 = 1000;
    four_bit_and_gate three_bit_and_gate_1(.a({cnt[3],not_2,not_1,not_0}), .out(addr[3]));
    
    // a2 = 0010 + 01-1 + 010-;
    four_bit_and_gate four_bit_and_gate_2(.a({not_3,not_2,cnt[1],not_0}), .out(out_1));
    three_bit_and_gate three_bit_and_gate_2(.a({not_3,cnt[2],cnt[0]}), .out(out_2));
    three_bit_and_gate three_bit_and_gate_3(.a({not_3,cnt[2],not_1}), .out(out_3));
    or_gate or_gate_3(.a(out_1),.b(out_2),.out(or_out_1));
    or_gate or_gate_4(.a(out_3),.b(or_out_1),.out(addr[2]));

    // a1 = 0-10 + 0-01;
    three_bit_and_gate three_bit_and_gate_4(.a({not_3,cnt[1],not_0}), .out(out_4));
    three_bit_and_gate three_bit_and_gate_5(.a({not_3,not_1,cnt[0]}), .out(out_5));
    or_gate or_gate_6(.a(out_4),.b(out_5),.out(addr[1]));

    // a0 = 0--1; 
    and_gate and_gate_1(.a(not_3), .b(cnt[0]),.out(addr[0]));
   

endmodule
