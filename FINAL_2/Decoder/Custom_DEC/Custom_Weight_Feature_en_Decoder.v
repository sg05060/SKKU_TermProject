module Custom_Feature_Weight_en_Decoder(
    input   [4:0] cnt,                
    output  [3:0] buff_en
    // output reg [3:0] buff_en     // this line is for behavioral test
);

    // Porting
    wire    [4:0]   cnt_not;
    wire    [5:0]   product3;       // about buff_en[3]
    wire    [5:0]   product2;       // about buff_en[2]
    wire    [6:0]   product1;       // about buff_en[1]
    wire    [5:0]   product0;       // about buff_en[0]

    wire    [1:0]   sum3;           // about buff_en[3]
    wire    [1:0]   sum2;           // about buff_en[2]
    wire    [1:0]   sum1;           // about buff_en[1]
    wire    [1:0]   sum0;           // about buff_en[0]

    wire    [3:0]   sum;            // SOP value -> buff_en
    
    
    // Boolean expression
    // buff_en[3] = 10100 | 10010 | 10-11 | 0010- | --000 | 010-- 
    // buff_en[2] = 01011 | 00110 | 10100 | 10010 | 0110- | 0--01
    // buff_en[1] = 10000 | 011-1 | 10101 | 01011 | -0110 | 00-10 | 0-11- 
    // buff_en[0] = 01111 | 00011 | 10010 | 0100- | 1000- | 1011-
    

    
    // NOT gating
    not_gate not_gate_0(.a(cnt[0]), .out(cnt_not[0]));
    not_gate not_gate_1(.a(cnt[1]), .out(cnt_not[1]));
    not_gate not_gate_2(.a(cnt[2]), .out(cnt_not[2]));
    not_gate not_gate_3(.a(cnt[3]), .out(cnt_not[3]));
    not_gate not_gate_4(.a(cnt[4]), .out(cnt_not[4]));
    
    
    // buff_en[3] = 10100 | 10010 | 10-11 | 0010- | --000 | 010-- 
    // buff_en[3] AND gating(Product)
    five_bit_and_gate   buff_en_product3_0(.a({cnt[4], cnt_not[3], cnt[2], cnt_not[1], cnt_not[0]}),    .out(product3[0]));      // 10100
    five_bit_and_gate   buff_en_product3_1(.a({cnt[4], cnt_not[3], cnt_not[2], cnt[1], cnt_not[0]}),    .out(product3[1]));      // 10010
    four_bit_and_gate   buff_en_product3_2(.a({cnt[4], cnt_not[3], cnt[1], cnt[0]}),                    .out(product3[2]));      // 10-11
    four_bit_and_gate   buff_en_product3_3(.a({cnt_not[4], cnt_not[3], cnt[2], cnt_not[1]}),            .out(product3[3]));      // 0010-
    three_bit_and_gate  buff_en_product3_4(.a({cnt_not[2], cnt_not[1], cnt_not[0]}),                    .out(product3[4]));      // --000
    three_bit_and_gate  buff_en_product3_5(.a({cnt_not[4], cnt[3], cnt_not[2]}),                        .out(product3[5]));      // 010--

    // buff_en[3] OR gating(Sum)
    three_bit_or_gate   buff_en_sum3_0(.a(product3[2:0]),           .out(sum3[0]));
    three_bit_or_gate   buff_en_sum3_1(.a(product3[5:3]),           .out(sum3[1]));
    or_gate             buff_en_sum3_2(.a(sum3[0]), .b(sum3[1]),    .out(sum[3]));      // buff_en[3]
    
    
    // buff_en[2] = 01011 | 00110 | 10100 | 10010 | 0110- | 0--01
    // buff_en[2] AND gating(Product)
    five_bit_and_gate   buff_en_product2_0(.a({cnt_not[4], cnt[3], cnt_not[2], cnt[1], cnt[0]}),        .out(product2[0]));      // 01011
    five_bit_and_gate   buff_en_product2_1(.a({cnt_not[4], cnt_not[3], cnt[2], cnt[1], cnt_not[0]}),    .out(product2[1]));      // 00110
    five_bit_and_gate   buff_en_product2_2(.a({cnt[4], cnt_not[3], cnt[2], cnt_not[1], cnt_not[0]}),    .out(product2[2]));      // 10100
    five_bit_and_gate   buff_en_product2_3(.a({cnt[4], cnt_not[3], cnt_not[2], cnt[1], cnt_not[0]}),    .out(product2[3]));      // 10010
    four_bit_and_gate   buff_en_product2_4(.a({cnt_not[4], cnt[3], cnt[2], cnt_not[1]}),                .out(product2[4]));      // 0110-
    three_bit_and_gate  buff_en_product2_5(.a({cnt_not[4], cnt_not[1], cnt[0]}),                        .out(product2[5]));      // 0--01

    // buff_en[2] OR gating(Sum)
    three_bit_or_gate   buff_en_sum2_0(.a(product2[2:0]),           .out(sum2[0]));
    three_bit_or_gate   buff_en_sum2_1(.a(product2[5:3]),           .out(sum2[1]));
    or_gate             buff_en_sum2_2(.a(sum2[0]), .b(sum2[1]),    .out(sum[2]));      // buff_en[2]
    

    // buff_en[1] = 10000 | 011-1 | 10101 | 01011 | -0110 | 00-10 | 0-11-     
    // buff_en[1] AND gating(Product)
    five_bit_and_gate   buff_en_product1_0(.a({cnt[4], cnt_not[3], cnt_not[2], cnt_not[1], cnt_not[0]}),    .out(product1[0]));      // 10000
    four_bit_and_gate   buff_en_product1_1(.a({cnt_not[4], cnt[3], cnt[2], cnt[0]}),                        .out(product1[1]));      // 011-1
    five_bit_and_gate   buff_en_product1_2(.a({cnt[4], cnt_not[3], cnt[2], cnt_not[1], cnt[0]}),            .out(product1[2]));      // 10101
    five_bit_and_gate   buff_en_product1_3(.a({cnt_not[4], cnt[3], cnt_not[2], cnt[1], cnt[0]}),            .out(product1[3]));      // 01011
    four_bit_and_gate   buff_en_product1_4(.a({cnt_not[3], cnt[2], cnt[1], cnt_not[0]}),                    .out(product1[4]));      // -0110
    four_bit_and_gate   buff_en_product1_5(.a({cnt_not[4], cnt_not[3], cnt[1], cnt_not[0]}),                .out(product1[5]));      // 00-10
    three_bit_and_gate  buff_en_product1_6(.a({cnt_not[4], cnt[2], cnt[1]}),                                .out(product1[6]));      // 0-11-
    
    // buff_en[1] OR gating(sum)
    four_bit_or_gate    buff_en_sum1_0(.a(product1[3:0]),            .out(sum1[0]));
    three_bit_or_gate   buff_en_sum1_1(.a(product1[6:4]),            .out(sum1[1]));
    or_gate             buff_en_sum1_2(.a(sum1[0]), .b(sum1[1]),    .out(sum[1]));      // buff_en[1]
    
    
    // buff_en[0] = 01111 | 00011 | 10010 | 0100- | 1000- | 1011-    
    // buff_en[0] AND gating(Product)
    five_bit_and_gate   buff_en_product0_0(.a({cnt_not[4], cnt[3], cnt[2], cnt[1], cnt[0]}),            .out(product0[0]));      // 01111
    five_bit_and_gate   buff_en_product0_1(.a({cnt_not[4], cnt_not[3], cnt_not[2], cnt[1], cnt[0]}),    .out(product0[1]));      // 00011
    five_bit_and_gate   buff_en_product0_2(.a({cnt[4], cnt_not[3], cnt_not[2], cnt[1], cnt_not[0]}),    .out(product0[2]));      // 10010
    four_bit_and_gate   buff_en_product0_3(.a({cnt_not[4], cnt[3], cnt_not[2], cnt_not[1]}),            .out(product0[3]));      // 0100-
    four_bit_and_gate   buff_en_product0_4(.a({cnt[4], cnt_not[3], cnt_not[2], cnt_not[1]}),            .out(product0[4]));      // 1000-
    four_bit_and_gate   buff_en_product0_5(.a({cnt[4], cnt_not[3], cnt[2], cnt[1]}),                    .out(product0[5]));      // 1011-

    // buff_en[0] OR gating(sum)
    three_bit_or_gate   buff_en_sum0_0(.a(product0[2:0]),           .out(sum0[0]));
    three_bit_or_gate   buff_en_sum0_1(.a(product0[5:3]),           .out(sum0[1]));
    or_gate             buff_en_sum0_2(.a(sum0[0]), .b(sum0[1]),    .out(sum[0]));      // buff_en[0]
    
    
    // assign out
    assign buff_en = sum;
    
    
    // behavioral logic(not use)
    // always @(*) begin
    //     case(cnt)
    //         5'b0_0000 : buff_en = 4'b1000;
    //         5'b0_0001 : buff_en = 4'b0100;
    //         5'b0_0010 : buff_en = 4'b0010;
    //         5'b0_0011 : buff_en = 4'b0001;
    //         5'b0_0100 : buff_en = 4'b1000;
    //         5'b0_0101 : buff_en = 4'b1100;
    //         5'b0_0110 : buff_en = 4'b0110;
    //         5'b0_0111 : buff_en = 4'b0010;
    //         5'b0_1000 : buff_en = 4'b1001;
    //         5'b0_1001 : buff_en = 4'b1101;
    //         5'b0_1010 : buff_en = 4'b1000;
    //         5'b0_1011 : buff_en = 4'b1110;
    //         5'b0_1100 : buff_en = 4'b0100;
    //         5'b0_1101 : buff_en = 4'b0110;
    //         5'b0_1110 : buff_en = 4'b0010;
    //         5'b0_1111 : buff_en = 4'b0011;
    //         5'b1_0000 : buff_en = 4'b1011;
    //         5'b1_0001 : buff_en = 4'b0001;
    //         5'b1_0010 : buff_en = 4'b1101;
    //         5'b1_0011 : buff_en = 4'b1000;
    //         5'b1_0100 : buff_en = 4'b1100;
    //         5'b1_0101 : buff_en = 4'b0010;
    //         5'b1_0110 : buff_en = 4'b0011;
    //         5'b1_0111 : buff_en = 4'b1001;
    //         5'b1_1000 : buff_en = 4'b1000;
    //         default   : buff_en = 4'b0000;
    //     endcase
    // end
    
    

endmodule