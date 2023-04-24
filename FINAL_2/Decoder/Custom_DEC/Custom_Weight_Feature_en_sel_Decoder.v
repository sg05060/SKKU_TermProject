module Custom_Feature_Weight_en_SEL_Decoder(
    input [4:0] cnt,                
    output      feature_weight_en_sel
    // output reg feature_weight_en_sel // this line is for behavioral modeling
);

    // Boolean expression
    // en_sel = -1000 | 01--1 | 10--0 | -01--
    
    wire [4:0]  cnt_not;
    wire [3:0]  product0;
    wire        sum0;
    
    // NOT gating
    not_gate not_gate_0(.a(cnt[0]), .out(cnt_not[0]));
    not_gate not_gate_1(.a(cnt[1]), .out(cnt_not[1]));
    not_gate not_gate_2(.a(cnt[2]), .out(cnt_not[2]));
    not_gate not_gate_3(.a(cnt[3]), .out(cnt_not[3]));
    not_gate not_gate_4(.a(cnt[4]), .out(cnt_not[4]));
    
    // en_sel AND gating(Product)
    four_bit_and_gate   en_sel_product0_0(.a({cnt[3], cnt_not[2], cnt_not[1], cnt_not[0]}),    .out(product0[0]) );     // -1000
    three_bit_and_gate  en_sel_product0_1(.a({cnt_not[4], cnt[3], cnt[0]}),                    .out(product0[1]) );     // 01--1
    three_bit_and_gate  en_sel_product0_2(.a({cnt[4], cnt_not[3], cnt_not[0]}),                .out(product0[2]) );     // 10--0
    and_gate            en_sel_product0_3(.a(cnt_not[3]), .b(cnt[2]),                          .out(product0[3]) );     // -01--
    
    // en_sel OR gating(Sum)
    four_bit_or_gate SOP_en_sel(
        .a  (product0), 
        .out(sum0)
    );
    
    
    // assign out
    assign feature_weight_en_sel = sum0;
    
    
    // Behavioral modeling(not use)
    
    //always @(*) begin
    //    case(cnt)
    //        5'b0_0000 : feature_weight_en_sel = 1'b0;
    //        5'b0_0001 : feature_weight_en_sel = 1'b0;
    //        5'b0_0010 : feature_weight_en_sel = 1'b0;
    //        5'b0_0011 : feature_weight_en_sel = 1'b0;
    //        5'b0_0100 : feature_weight_en_sel = 1'b1;
    //        5'b0_0101 : feature_weight_en_sel = 1'b1;
    //        5'b0_0110 : feature_weight_en_sel = 1'b1;
    //        5'b0_0111 : feature_weight_en_sel = 1'b1;
    //        5'b0_1000 : feature_weight_en_sel = 1'b1;
    //        5'b0_1001 : feature_weight_en_sel = 1'b1;
    //        5'b0_1010 : feature_weight_en_sel = 1'b0;
    //        5'b0_1011 : feature_weight_en_sel = 1'b1;
    //        5'b0_1100 : feature_weight_en_sel = 1'b0;
    //        5'b0_1101 : feature_weight_en_sel = 1'b1;
    //        5'b0_1110 : feature_weight_en_sel = 1'b0;
    //        5'b0_1111 : feature_weight_en_sel = 1'b1;
    //        5'b1_0000 : feature_weight_en_sel = 1'b1;
    //        5'b1_0001 : feature_weight_en_sel = 1'b0;
    //        5'b1_0010 : feature_weight_en_sel = 1'b1;
    //        5'b1_0011 : feature_weight_en_sel = 1'b0;
    //        5'b1_0100 : feature_weight_en_sel = 1'b1;
    //        5'b1_0101 : feature_weight_en_sel = 1'b1;
    //        5'b1_0110 : feature_weight_en_sel = 1'b1;
    //        5'b1_0111 : feature_weight_en_sel = 1'b1;
    //        5'b1_1000 : feature_weight_en_sel = 1'b1;
    //        default   : feature_weight_en_sel = 1'b0;
    //    endcase
    //end
    
    
endmodule