module Custom_Feature_Weight_en_SEL_Decoder(
    input [4:0] cnt,                
    output reg feature_weight_en_sel
);
    always @(*) begin
        case(cnt)
            5'b0_0000 : feature_weight_en_sel = 1'b0;
            5'b0_0001 : feature_weight_en_sel = 1'b0;
            5'b0_0010 : feature_weight_en_sel = 1'b0;
            5'b0_0011 : feature_weight_en_sel = 1'b0;
            5'b0_0100 : feature_weight_en_sel = 1'b1;
            5'b0_0101 : feature_weight_en_sel = 1'b1;
            5'b0_0110 : feature_weight_en_sel = 1'b1;
            5'b0_0111 : feature_weight_en_sel = 1'b1;
            5'b0_1000 : feature_weight_en_sel = 1'b1;
            5'b0_1001 : feature_weight_en_sel = 1'b1;
            5'b0_1010 : feature_weight_en_sel = 1'b0;
            5'b0_1011 : feature_weight_en_sel = 1'b1;
            5'b0_1100 : feature_weight_en_sel = 1'b0;
            5'b0_1101 : feature_weight_en_sel = 1'b1;
            5'b0_1110 : feature_weight_en_sel = 1'b0;
            5'b0_1111 : feature_weight_en_sel = 1'b1;
            5'b1_0000 : feature_weight_en_sel = 1'b1;
            5'b1_0001 : feature_weight_en_sel = 1'b0;
            5'b1_0010 : feature_weight_en_sel = 1'b1;
            5'b1_0011 : feature_weight_en_sel = 1'b0;
            5'b1_0100 : feature_weight_en_sel = 1'b1;
            5'b1_0101 : feature_weight_en_sel = 1'b1;
            5'b1_0110 : feature_weight_en_sel = 1'b1;
            5'b1_0111 : feature_weight_en_sel = 1'b1;
            5'b1_1000 : feature_weight_en_sel = 1'b1;
            default   : feature_weight_en_sel = 1'b0;
        endcase
    end
    
    // Binary output expression
    // -1000 1
    // 01--1 1
    // 10--0 1
    // -01-- 1
    
    // Boolean expression
    // en_sel = -1000 | 01--1 | 10--0 | -01--
    
endmodule