module Custom_Buff_use_Decoder(
    input   [4:0]   cnt,
    output  [3:0]   buff_use
    // output reg  [3:0]   buff_use     // this line is for behavioral test
);

    // Porting
    wire    [4:0]   cnt_not;
    
    wire    [8:0]   product3;       // about buff_use[3]
    wire    [6:0]   product2;       // about buff_use[2]
    wire    [4:0]   product1;       // about buff_use[1]
    wire    [4:0]   prodcut0;       // about buff_use[0]

    wire    [2:0]   sum3;           // about buff_use[3]    -> 3 | 3 | 3
    wire    [1:0]   sum2;           // about buff_use[2]    -> 4 | 3
    wire    [1:0]   sum1;           // about buff_use[1]    -> 3 | 2
    wire    [1:0]   sum0;           // about buff_use[0]    -> 3 | 2
    
    wire    [3:0]   sum;            // SOP value -> buff_use

    // boolean expression
    // buff_use[3] = 01100 | 11000 | 00110 | 10011 | 01010 | 010-1 | 1-001 | -0101 | 1010-
    // buff_use[2] = 10101 | 00111 | 00110 | 10011 | 01010 | 0110- | 011-0
    // buff_use[1] = 00111 | 01-00 | 1011- | 1000- | 011-0 
    // buff_use[0] = 01001 | 11000 | 10-11 | 01010 | 100--


    // NOT gating
    not_gate not_gate_0(.a(cnt[0]), .out(cnt_not[0]));
    not_gate not_gate_1(.a(cnt[1]), .out(cnt_not[1]));
    not_gate not_gate_2(.a(cnt[2]), .out(cnt_not[2]));
    not_gate not_gate_3(.a(cnt[3]), .out(cnt_not[3]));
    not_gate not_gate_4(.a(cnt[4]), .out(cnt_not[4]));


    // buff_use[3] = 01100 | 11000 | 00110 | 10011 | 01010 | 010-1 | 1-001 | -0101 | 1010-
    // buff_use[3] AND gating(Product)
    five_bit_and_gate   buff_use_product3_0(.a({cnt_not[4], cnt[3], cnt[2], cnt_not[1], cnt_not[0]}),   .out(product3[0]));     // 01100
    five_bit_and_gate   buff_use_product3_1(.a({cnt[4], cnt[3], cnt_not[2], cnt_not[1], cnt_not[0]}),   .out(product3[1]));     // 11000
    five_bit_and_gate   buff_use_product3_2(.a({cnt_not[4], cnt_not[3], cnt[2], cnt[1], cnt_not[0]}),   .out(product3[2]));     // 00110
    five_bit_and_gate   buff_use_product3_3(.a({cnt[4], cnt_not[3], cnt_not[2], cnt[1], cnt[0]}),       .out(product3[3]));     // 10011
    five_bit_and_gate   buff_use_product3_4(.a({cnt_not[4], cnt[3], cnt_not[2], cnt[1], cnt_not[0]}),   .out(product3[4]));     // 01010
    fout_bit_and_gate   buff_use_product3_5(.a({cnt_not[4], cnt[3], cnt_not[2], cnt[0]}),               .out(product3[5]));     // 010-1
    four_bit_and_gate   buff_use_product3_6(.a({cnt[4], cnt_not[2], cnt_not[1], cnt[0]}),               .out(product3[6]));     // 1-001
    four_bit_and_gate   buff_use_product3_7(.a({cnt_not[3], cnt[2], cnt_not[1], cnt[0]}),               .out(product3[7]));     // -0101
    four_bit_and_gate   buff_use_product3_8(.a({cnt[4], cnt_not[3], cnt[2], cnt_not[1]}),               .out(product3[8]));     // 1010-

    // buff_use[3] OR gating(Sum)
    three_bit_or_gate   buff_use_sum3_0(.a(product3[2:0]),    .out(sum3[0]));
    three_bit_or_gate   buff_use_sum3_1(.a(product3[5:3]),    .out(sum3[1]));
    three_bit_or_gate   buff_use_sum3_2(.a(product3[8:6]),    .out(sum3[2]));
    three_bit_or_gate   buff_use_sum3_3(.a(sum3),             .out(sum[3]));      // buff_use[3]


    // buff_use[2] = 10101 | 00111 | 00110 | 10011 | 01010 | 0110- | 011-0
    // buff_use[2] AND gating(Product)
    five_bit_and_gate   buff_use_product2_0(.a({cnt[4], cnt_not[3], cnt[2], cnt_not[1], cnt[0]}),       .out(product2[0]));     // 10101
    five_bit_and_gate   buff_use_product2_1(.a({cnt_not[4], cnt_not[3], cnt[2], cnt[1], cnt[0]}),       .out(product2[1]));     // 00111
    five_bit_and_gate   buff_use_product2_2(.a({cnt_not[4], cnt_not[3], cnt[2], cnt[1], cnt_not[0]}),   .out(product2[2]));     // 00110
    five_bit_and_gate   buff_use_product2_3(.a({cnt[4], cnt_not[3], cnt_not[2], cnt[1], cnt[0]}),       .out(product2[3]));     // 10011
    five_bit_and_gate   buff_use_product2_4(.a({cnt_not[4], cnt[3], cnt_not[2], cnt[1], cnt_not[0]}),   .out(product2[4]));     // 01010
    four_bit_and_gate   buff_use_product2_5(.a({cnt_not[4], cnt[3], cnt[2], cnt_not[1]}),               .out(product2[5]));     // 0110-
    four_bit_and_gate   buff_use_product2_6(.a({cnt_not[4], cnt[3], cnt[2], cnt_not[0]}),               .out(product2[6]));     // 011-0
    
    // buff_use[2] OR gating(Sum)
    four_bit_or_gate    buff_use_sum2_0(.a(product2[3:0]),          .out(sum2[0]));
    three_bit_or_gate   buff_use_sum2_1(.a(product2[6:4]),          .out(sum2[1]));
    or_gate             buff_use_sum2_2(.a(sum2[0]), .b(sum2[1]),   .out(sum[2]));    // buff_use[2]
    
    
    // buff_use[1] = 00111 | 01-00 | 1011- | 1000- | 011-0 
    // buff_use[1] AND gating(Product)
    five_bit_and_gate   buff_use_product1_0(.a({cnt_not[4], cnt_not[3], cnt[2], cnt[1], cnt[0]}),       .out(product1[0]));     // 00111
    four_bit_and_gate   buff_use_product1_1(.a({cnt_not[4], cnt[3], cnt_not[1], cnt_not[0]}),           .out(product1[1]));     // 01-00
    four_bit_and_gate   buff_use_product1_2(.a({cnt[4], cnt_not[3], cnt[2], cnt[1]}),                   .out(product1[2]));     // 1011-
    four_bit_and_gate   buff_use_product1_3(.a({cnt[4], cnt_not[3], cnt_not[2], cnt_not[1]}),           .out(product1[3]));     // 1000-
    four_bit_and_gate   buff_use_product1_4(.a({cnt_not[4], cnt[3], cnt[2], cnt_not[0]}),               .out(product1[4]));     // 011-0
    
    // buff_use[1] OR gating(Sum)
    three_bit_or_gate   buff_use_sum1_0(.a(product1[2:0]),                  .out(sum1[0]));
    or_gate             buff_use_sum1_1(.a(product1[3]), .b(product1[4]),   .out(sum1[1]));
    or_gate             buff_use_sum1_2(.a(sum1[0]), .b(sum1[1]),           .out(sum[1]));    // buff_use[1]
    

    // buff_use[0] = 01001 | 11000 | 10-11 | 01010 | 100--
    // buff_use[0] AND gating(Product)
    five_bit_and_gate   buff_use_product0_0(.a({cnt_not[4], cnt[3], cnt_not[2], cnt_not[1], cnt[0]}),     .out(product0[0]));       // 01001
    five_bit_and_gate   buff_use_product0_1(.a({cnt[4], cnt[3], cnt_not[2], cnt_not[1], cnt_not[0]}),     .out(product0[1]));       // 11000
    four_bit_and_gate   buff_use_product0_2(.a({cnt[4], cnt_not[3], cnt[1], cnt[0]}),                     .out(product0[2]));       // 10-11
    five_bit_and_gate   buff_use_product0_3(.a({cnt_not[4], cnt[3], cnt_not[2], cnt[1], cnt_not[0]}),     .out(product0[3]));       // 01010
    three_bit_and_gate  buff_use_product0_4(.a({cnt[4], cnt_not[3], cnt_not[2]}),                         .out(product0[4]));       // 100--
    
    // buff_use[0] OR gating(Sum)
    three_bit_or_gate   buff_use_sum0_0(.a(product0[2:0]),                  .out(sum0[0]));
    or_gate             buff_use_sum0_1(.a(product0[3]), .b(product0[4]),   .out(sum0[1]));
    or_gate             buff_use_sum0_2(.a(sum0[0]), .b(sum0[1]),           .out(sum[0]));    // buff_use[1]
    
    
    // assign out
    assign buff_use = sum;
    

    // always @(*) begin
    //     case(cnt)
    //         5'b0_0000 : buff_use = 4'b0000;
    //         5'b0_0001 : buff_use = 4'b0000;
    //         5'b0_0010 : buff_use = 4'b0000;
    //         5'b0_0011 : buff_use = 4'b0000;
    //         5'b0_0100 : buff_use = 4'b0000;
    //         5'b0_0101 : buff_use = 4'b1000;
    //         5'b0_0110 : buff_use = 4'b1100;
    //         5'b0_0111 : buff_use = 4'b0110;
    //         5'b0_1000 : buff_use = 4'b0010;
    //         5'b0_1001 : buff_use = 4'b1001;
    //         5'b0_1010 : buff_use = 4'b1101;
    //         5'b0_1011 : buff_use = 4'b1000;
    //         5'b0_1100 : buff_use = 4'b1110;
    //         5'b0_1101 : buff_use = 4'b0100;
    //         5'b0_1110 : buff_use = 4'b0110;
    //         5'b0_1111 : buff_use = 4'b0000;
    //         5'b1_0000 : buff_use = 4'b0011;
    //         5'b1_0001 : buff_use = 4'b1011;
    //         5'b1_0010 : buff_use = 4'b0001;
    //         5'b1_0011 : buff_use = 4'b1101;
    //         5'b1_0100 : buff_use = 4'b1000;
    //         5'b1_0101 : buff_use = 4'b1100;
    //         5'b1_0110 : buff_use = 4'b0010;
    //         5'b1_0111 : buff_use = 4'b0011;
    //         5'b1_1000 : buff_use = 4'b1001;
    //         5'b1_1001 : buff_use = 4'b1000;
    //         default   : buff_use = 4'b0000;
    //     endcase
    // end

    
endmodule