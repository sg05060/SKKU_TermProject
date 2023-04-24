module Custom_Addr_Decoder(
    input   [4:0]   cnt,
    output  [5:0]   addr
    // output reg [5:0] addr       // this line is for behavioral test 
);

    // Porting
    wire    [4:0]   cnt_not;

    wire    [3:0]   product4;       // about addr[4]
    wire    [6:0]   product3;       // about addr[3]
    wire    [4:0]   product2;       // about addr[2]
    wire    [7:0]   product1;       // about addr[1]
    wire    [6:0]   product0;       // about addr[0]
    
    wire    [1:0]   sum3;           // about addr[3]    -> 4 | 3
    wire    [1:0]   sum2;           // about addr[2]    -> 3 | 2
    wire    [1:0]   sum1;           // about addr[1]    -> 4 | 4
    wire    [1:0]   sum0;           // about addr[0]    -> 4 | 3

    wire    [4:0]   sum;            // SOP value -> addr is 6bit, msb is always 1'b0, other 5bit is select by cnt - dec activation
                                    // MSB is always 1'b0 -> we use only 25 value(feature 16, weight 9)
    // boolean expression
    // addr[5] = none
    // addr[4] = 11000 | 011-1 | 100-0 | 101--
    // addr[3] = 11000 | 10011 | 0100- | 00111 | 00101 | 001-0 | 010-1
    // addr[2] = 10001 | 00111 | 01--0 | 010-1 | 101--
    // addr[1] = 10001 | 00101 | 0-110 | 1011- | 100-0 | 0-011 | -0-10 | 010-1
    // addr[0] = 10010 | 01-00 | 01-11 | -0001 | 101-1 | 001-0 | 0-011


    // NOT gating
    not_gate not_gate_0(.a(cnt[0]), .out(cnt_not[0]));
    not_gate not_gate_1(.a(cnt[1]), .out(cnt_not[1]));
    not_gate not_gate_2(.a(cnt[2]), .out(cnt_not[2]));
    not_gate not_gate_3(.a(cnt[3]), .out(cnt_not[3]));
    not_gate not_gate_4(.a(cnt[4]), .out(cnt_not[4]));


    // addr[4] = 11000 | 011-1 | 100-0 | 101--
    // addr[4] AND gating(Product)
    five_bit_and_gate   addr_product4_0(.a({cnt[4], cnt[3], cnt_not[2], cnt_not[1], cnt_not[0]}), .out(product4[0]));       // 11000
    four_bit_and_gate   addr_product4_1(.a({cnt_not[4], cnt[3], cnt[2], cnt[0]}),                 .out(product4[1]));       // 011-1
    four_bit_and_gate   addr_product4_2(.a({cnt[4], cnt_not[3], cnt_not[2], cnt_not[0]}),         .out(product4[2]));       // 100-0
    three_bit_and_gate  addr_product4_3(.a({cnt[4], cnt_not[3], cnt[2]}),                         .out(product4[3]));       // 101--
    
    // addr[4] OR gating(Sum)
    four_bit_or_gate    addr_sum4_0(.a(product4), .out(sum[4]));        // addr[4]


    // addr[3] = 11000 | 10011 | 0100- | 00111 | 00101 | 001-0 | 010-1
    // addr[3] AND gating(Product)
    five_bit_and_gate   addr_product3_0(.a({cnt[4], cnt[3], cnt_not[2], cnt_not[1], cnt_not[0]}), .out(product3[0]));      // 11000
    five_bit_and_gate   addr_product3_1(.a({cnt[4], cnt_not[3], cnt_not[2], cnt[1], cnt[0]}),     .out(product3[1]));      // 10011
    four_bit_and_gate   addr_product3_2(.a({cnt_not[4], cnt[3], cnt_not[2], cnt_not[1]}),         .out(product3[2]));      // 0100-
    five_bit_and_gate   addr_product3_3(.a({cnt_not[4], cnt_not[3], cnt[2], cnt[1], cnt[0]}),     .out(product3[3]));      // 00111
    five_bit_and_gate   addr_product3_4(.a({cnt_not[4], cnt_not[3], cnt[2], cnt_not[1], cnt[0]}), .out(product3[4]));      // 00101
    four_bit_and_gate   addr_product3_5(.a({cnt_not[4], cnt_not[3], cnt[2], cnt_not[0]}),         .out(product3[5]));      // 001-0
    four_bit_and_gate   addr_product3_6(.a({cnt_not[4], cnt[3], cnt_not[2], cnt[0]}),             .out(product3[6]));      // 010-1
    
    // addr[3] OR gating(Sum)
    four_bit_or_gate    addr_sum3_0(.a(product3[3:0]), .out(sum3[0]));
    three_bit_or_gate   addr_sum3_1(.a(product3[6:4]), .out(sum3[1]));
    or_gate             addr_sum3_2(.a(sum3[0]), .b(sum3[1]), .out(sum[3]));        // addr[3]
    
    
    // addr[2] = 10001 | 00111 | 01--0 | 010-1 | 101--
    // addr[2] AND gating(Product)
    five_bit_and_gate   addr_product2_0(.a({cnt[4], cnt_not[3], cnt_not[2], cnt_not[1], cnt[0]}),   .out(product2[0]));       // 10001
    five_bit_and_gate   addr_product2_1(.a({cnt_not[4], cnt_not[3], cnt[2], cnt[1], cnt[0]}),       .out(product2[1]));       // 00111
    three_bit_and_gate  addr_product2_2(.a({cnt_not[4], cnt[3], cnt_not[0]}),                       .out(product2[2]));       // 01--0
    four_bit_and_gate   addr_product2_3(.a({cnt_not[4], cnt[3], cnt_not[2], cnt[0]}),               .out(product2[3]));       // 010-1
    three_bit_and_gate  addr_product2_4(.a({cnt[4], cnt_not[3], cnt[2]}),                           .out(product2[4]));       // 101--
    
    // addr[2] OR gating(Sum)
    three_bit_or_gate   addr_sum2_0(.a(product2[2:0]),                  .out(sum2[0]));
    or_gate             addr_sum2_1(.a(product2[3]), .b(product2[4]),    .out(sum2[1]));
    or_gate             addr_sum2_2(.a(sum2[0]), .b(sum2[1]),           .out(sum[2]));      // addr[2]
    
    
    // addr[1] = 10001 | 00101 | 0-110 | 1011- | 100-0 | 0-011 | -0-10 | 010-1
    // addr[1] AND gating(Product)
    five_bit_and_gate   addr_product1_0(.a({cnt[4], cnt_not[3], cnt_not[2], cnt_not[1], cnt[0]}),   .out(product1[0]));     // 10001
    five_bit_and_gate   addr_product1_1(.a({cnt_not[4], cnt_not[3], cnt[2], cnt_not[1], cnt[0]}),   .out(product1[1]));     // 00101
    four_bit_and_gate   addr_product1_2(.a({cnt_not[4], cnt[2], cnt[1], cnt_not[0]}),               .out(product1[2]));     // 0-110
    four_bit_and_gate   addr_product1_3(.a({cnt[4], cnt_not[3], cnt[2], cnt[1]}),                   .out(product1[3]));     // 1011-
    four_bit_and_gate   addr_product1_4(.a({cnt[4], cnt_not[3], cnt_not[2], cnt_not[0]}),           .out(product1[4]));     // 100-0
    four_bit_and_gate   addr_product1_5(.a({cnt_not[4], cnt_not[2], cnt[1], cnt[0]}),               .out(product1[5]));     // 0-011
    three_bit_and_gate  addr_product1_6(.a({cnt_not[3], cnt[1], cnt_not[0]}),                       .out(product1[6]));     // -0-10
    four_bit_and_gate   addr_product1_7(.a({cnt_not[4], cnt[3], cnt_not[2], cnt[0]}),               .out(product1[7]));     // 010-1
    
    // addr[1] OR gating(Sum)
    four_bit_or_gate    addr_sum1_0(.a(product1[3:0]), .out(sum1[0]));
    four_bit_or_gate    addr_sum1_1(.a(product1[7:4]), .out(sum1[1]));
    or_gate             addr_sum1_2(.a(sum1[0]), .b(sum1[1]), .out(sum[1]));


    // addr[0] = 10010 | 01-00 | 01-11 | -0001 | 101-1 | 001-0 | 0-011
    // addr[0] AND gating(Product)
    five_bit_and_gate   addr_product0_0(.a({cnt[4], cnt_not[3], cnt_not[2], cnt[1], cnt_not[0]}),     .out(product0[0]));      // 10010
    four_bit_and_gate   addr_product0_1(.a({cnt_not[4], cnt[3], cnt_not[1], cnt_not[0]}),             .out(product0[1]));      // 01-00
    four_bit_and_gate   addr_product0_2(.a({cnt_not[4], cnt[3], cnt[1], cnt[0]}),                     .out(product0[2]));      // 01-11
    four_bit_and_gate   addr_product0_3(.a({cnt_not[3], cnt_not[2], cnt_not[1], cnt[0]}),             .out(product0[3]));      // -0001
    four_bit_and_gate   addr_product0_4(.a({cnt[4], cnt_not[3], cnt[2], cnt[0]}),                     .out(product0[4]));      // 101-1
    four_bit_and_gate   addr_product0_5(.a({cnt_not[4], cnt_not[3], cnt[2], cnt_not[0]}),             .out(product0[5]));      // 001-0
    four_bit_and_gate   addr_product0_6(.a({cnt_not[4], cnt_not[2], cnt[1], cnt[0]}),                 .out(product0[6]));      // 0-011
    
    // addr[0] OR gating(Sum)
    four_bit_or_gate    addr_sum0_0(.a(product0[3:0]), .out(sum0[0]));
    three_bit_or_gate   addr_sum0_1(.a(product0[6:4]), .out(sum0[1]));
    or_gate             addr_sum0_2(.a(sum0[0]), .b(sum0[1]), .out(sum[0]));


    // assign out
    assign addr = {1'b0, sum};


    // Behavioral code(not use)
    // always @(*) begin
    //     case(cnt)
    //         5'b0_0000 : addr = 6'b00_0000;
    //         5'b0_0001 : addr = 6'b00_0001;
    //         5'b0_0010 : addr = 6'b00_0010;
    //         5'b0_0011 : addr = 6'b00_0011;
    //         5'b0_0100 : addr = 6'b00_1001;
    //         5'b0_0101 : addr = 6'b00_1010;
    //         5'b0_0110 : addr = 6'b00_1011;
    //         5'b0_0111 : addr = 6'b00_1100;
    //         5'b0_1000 : addr = 6'b00_1101;
    //         5'b0_1001 : addr = 6'b00_1110;
    //         5'b0_1010 : addr = 6'b00_0100;
    //         5'b0_1011 : addr = 6'b00_1111;
    //         5'b0_1100 : addr = 6'b00_0101;
    //         5'b0_1101 : addr = 6'b01_0000;
    //         5'b0_1110 : addr = 6'b00_0110;
    //         5'b0_1111 : addr = 6'b01_0001;
    //         5'b1_0000 : addr = 6'b01_0010;
    //         5'b1_0001 : addr = 6'b00_0111;
    //         5'b1_0010 : addr = 6'b01_0011;
    //         5'b1_0011 : addr = 6'b00_1000;
    //         5'b1_0100 : addr = 6'b01_0100;
    //         5'b1_0101 : addr = 6'b01_0101;
    //         5'b1_0110 : addr = 6'b01_0110;
    //         5'b1_0111 : addr = 6'b01_0111;
    //         5'b1_1000 : addr = 6'b01_1000;
    //         default   : addr = 6'b00_0000;
    //     endcase
    // end
    

endmodule