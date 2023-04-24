module Custom_ACC_en_Decoder(
    input   [4:0] cnt,            
    output  [3:0] acc_en
    // output reg [3:0] acc_en     // this line is for behavioral test
);
    
    // Porting
    wire    [4:0]   cnt_not;
    
    wire    [4:0]   product3;       // about acc_en[3]
    wire    [3:0]   product2;       // about acc_en[2]
    wire    [6:0]   product1;       // about acc_en[1]
    wire    [4:0]   product0;       // about acc_en[0]

    wire    [1:0]   sum3;           // about acc_en[3]  -> 3 | 2
    // wire         sum2;           // about acc_en[2]  -> 4
    wire    [1:0]   sum1;           // about acc_en[1]  -> 4 | 3
    wire    [1:0]   sum0;           // about acc_en[0]  -> 3 | 2
    
    wire    [3:0]   sum;

    // Boolean expression of acc_en[3:0]
    // acc_en[3] = 0-101 | 0011- | 010-1 | 10-00 | 100-0
    // acc_en[2] = 0011- | 10-01 | 01--0 | 100-1
    // acc_en[1] = 01010 | 01001 | 01100 | 1011- | 11000 | 1000- | 100-1
    // acc_en[0] = 01100 | 01-10 | 11000 | 1-001 | 10--1


    // NOT gating
    not_gate not_gate_0(.a(cnt[0]), .out(cnt_not[0]));
    not_gate not_gate_1(.a(cnt[1]), .out(cnt_not[1]));
    not_gate not_gate_2(.a(cnt[2]), .out(cnt_not[2]));
    not_gate not_gate_3(.a(cnt[3]), .out(cnt_not[3]));
    not_gate not_gate_4(.a(cnt[4]), .out(cnt_not[4]));


    // acc_en[3] = 0-101 | 0011- | 010-1 | 10-00 | 100-0
    // acc_en[3] AND gating(Product)
    four_bit_or_gate    acc_en_product3_0(.a({cnt_not[4], cnt[2], cnt_not[1], cnt[0]}),     .out(product3[0]));      // 0-101
    four_bit_or_gate    acc_en_product3_1(.a({cnt_not[4], cnt_not[3], cnt[2], cnt[1]}),     .out(product3[1]));      // 0011-
    four_bit_or_gate    acc_en_product3_2(.a({cnt_not[4], cnt[3], cnt_not[2], cnt[0]}),     .out(product3[2]));      // 010-1
    four_bit_or_gate    acc_en_product3_3(.a({cnt[4], cnt_not[3], cnt_not[1], cnt_not[0]}), .out(product3[3]));      // 10-00
    four_bit_or_gate    acc_en_product3_4(.a({cnt[4], cnt_not[3], cnt_not[2], cnt_not[0]}), .out(product3[4]));      // 100-0
    
    // acc_en[3] OR gating(Sum)
    three_bit_or_gate   acc_en_sum3_0(.a(product3[2:0]),                 .out(sum3[0]));
    or_gate             acc_en_sum3_1(.a(product3[3]), .b(product3[4]),  .out(sum3[1]));
    or_gate             acc_en_sum3_2(.a(sum3[0]), .b(sum3[1]),          .out(sum[3]));      // acc_en[3]
    
    
    // acc_en[2] = 0011- | 10-01 | 01--0 | 100-1
    // acc_en[2] AND gating(Product)
    four_bit_and_gate   acc_en_product2_0(.a({cnt_not[4], cnt_not[3], cnt[2], cnt[1]}),   .out(product2[0]));     // 0011-
    four_bit_and_gate   acc_en_product2_1(.a({cnt[4], cnt_not[3], cnt_not[1], cnt[0]}),   .out(product2[1]));     // 10-01
    three_bit_and_gate  acc_en_product2_2(.a({cnt_not[4], cnt[3], cnt_not[0]}),           .out(product2[2]));     // 01--0
    four_bit_and_gate   acc_en_product2_3(.a({cnt[4], cnt_not[3], cnt_not[2], cnt[0]}),   .out(product2[3]));     // 100-1
    
    // acc_en[2] OR gating(Sum)
    four_bit_or_gate    acc_en_sum2_0(.a(product2), .out(sum[2]));        // acc_en[2]


    // acc_en[1] = 01010 | 01001 | 01100 | 1011- | 11000 | 1000- | 100-1
    // acc_en[1] AND gating(Product)
    five_bit_and_gate   acc_en_product1_0(.a({cnt_not[4], cnt[3], cnt_not[2], cnt[1], cnt_not[0]}),   .out(product1[0]));     // 01010
    five_bit_and_gate   acc_en_product1_1(.a({cnt_not[4], cnt[3], cnt_not[2], cnt_not[1], cnt[0]}),   .out(product1[1]));     // 01001
    five_bit_and_gate   acc_en_product1_2(.a({cnt_not[4], cnt[3], cnt[2], cnt_not[1], cnt_not[0]}),   .out(product1[2]));     // 01100
    four_bit_and_gate   acc_en_product1_3(.a({cnt[4], cnt_not[3], cnt[2], cnt[1]}),                   .out(product1[3]));     // 1011-
    five_bit_and_gate   acc_en_product1_4(.a({cnt[4], cnt[3], cnt_not[2], cnt_not[1], cnt_not[0]}),   .out(product1[4]));     // 11000
    four_bit_and_gate   acc_en_product1_5(.a({cnt[4], cnt_not[3], cnt_not[2], cnt_not[1]}),           .out(product1[5]));     // 1000-
    four_bit_and_gate   acc_en_product1_6(.a({cnt[4], cnt_not[3], cnt_not[2], cnt[0]}),               .out(product1[6]));     // 100-1
    
    // acc_en[1] OR gating(Sum)
    four_bit_or_gate    acc_en_sum1_0(.a(product1[3:0]),        .out(sum1[0]));
    three_bit_or_gate   acc_en_sum1_1(.a(product1[6:4]),        .out(sum1[1]));
    or_gate             acc_en_sum1_2(.a(sum1[0]), .b(sum1[1]), .out(sum[1]));        // acc_en


    // acc_en[0] = 01100 | 01-10 | 11000 | 1-001 | 10--1
    // acc_en[0] AND gating(Product)
    five_bit_and_gate   acc_en_product0_0(.a({cnt_not[4], cnt[3], cnt[2], cnt_not[1], cnt_not[0]}),   .out(product0[0]));     // 01100
    four_bit_and_gate   acc_en_product0_1(.a({cnt_not[4], cnt[3], cnt[1], cnt_not[0]}),               .out(product0[1]));     // 01-10
    five_bit_and_gate   acc_en_product0_2(.a({cnt[4], cnt[3], cnt_not[2], cnt_not[1], cnt_not[0]}),   .out(product0[2]));     // 11000
    four_bit_and_gate   acc_en_product0_3(.a({cnt[4], cnt_not[2], cnt_not[1], cnt[0]}),               .out(product0[3]));     // 1-001
    three_bit_and_gate  acc_en_product0_4(.a({cnt[4], cnt_not[3], cnt[0]}),                           .out(product0[4]));     // 10--1
    
    // acc_en[0] OR gating(Sum)
    three_bit_or_gate   acc_en_sum0_0(.a(product0[2:0]),                    .out(sum0[0]));
    or_gate             acc_en_sum0_1(.a(product0[3]), .b(product0[4]),     .out(sum0[1]));
    or_gate             acc_en_sum0_2(.a(sum0[0]), .b(sum0[1]),             .out(sum[0]));      // acc_en[3]
    
    
    // assign out
    assign acc_en = sum;


    // always @(*) begin
    //     case(cnt)
    //         5'b0_0000 : acc_en = 4'b0000;
    //         5'b0_0001 : acc_en = 4'b0000;
    //         5'b0_0010 : acc_en = 4'b0000;
    //         5'b0_0011 : acc_en = 4'b0000;
    //         5'b0_0100 : acc_en = 4'b0000;
    //         5'b0_0101 : acc_en = 4'b1000;
    //         5'b0_0110 : acc_en = 4'b1100;
    //         5'b0_0111 : acc_en = 4'b1100;
    //         5'b0_1000 : acc_en = 4'b0100;
    //         5'b0_1001 : acc_en = 4'b1010;
    //         5'b0_1010 : acc_en = 4'b0111;
    //         5'b0_1011 : acc_en = 4'b1000;
    //         5'b0_1100 : acc_en = 4'b0111;
    //         5'b0_1101 : acc_en = 4'b1000;
    //         5'b0_1110 : acc_en = 4'b0101;
    //         5'b0_1111 : acc_en = 4'b0000;
    //         5'b1_0000 : acc_en = 4'b1010;
    //         5'b1_0001 : acc_en = 4'b0111;
    //         5'b1_0010 : acc_en = 4'b1000;
    //         5'b1_0011 : acc_en = 4'b0111;
    //         5'b1_0100 : acc_en = 4'b1000;
    //         5'b1_0101 : acc_en = 4'b0101;
    //         5'b1_0110 : acc_en = 4'b0010;
    //         5'b1_0111 : acc_en = 4'b0011;
    //         5'b1_1000 : acc_en = 4'b0011;
    //         5'b1_1001 : acc_en = 4'b0001;
    //         default   : acc_en = 4'b0000;
    //     endcase
    // end
    
    

    
    
endmodule