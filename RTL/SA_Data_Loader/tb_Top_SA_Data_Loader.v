module tb_Top_SA_Data_Loader;
    reg clk;
    reg rst;
    reg Weight_Preloader_en;
    reg Feature_Loader_en;
    reg [5:0] feature_baseaddr;
    reg mode;
    wire is_FL_done_o;
    wire is_WL_done_o;
    wire [7:0] feature_1;
    wire [7:0] feature_2;
    wire [7:0] feature_3;
    wire sa_reg_en;
    wire sa_en;
    wire [7:0] preload_weight_1;
    wire [7:0] preload_weight_2;
    wire [7:0] preload_weight_3;
    wire [7:0] preload_weight_4;
    wire [7:0] preload_weight_5;
    wire [7:0] preload_weight_6;
    wire [7:0] preload_weight_7;
    wire [7:0] preload_weight_8;
    wire [7:0] preload_weight_9;
    wire [7:0] preload_ens;

    Top_SA_Data_Loader Top(
    .clk(clk),
    .rst(rst),
    .Weight_Preloader_en(Weight_Preloader_en),
    .Feature_Loader_en(Feature_Loader_en),
    .feature_baseaddr(feature_baseaddr),
    .mode(mode),
    .is_FL_done_o(is_FL_done_o),
    .is_WL_done_o(is_WL_done_o),
    .feature_1(feature_1),
    .feature_2(feature_2),
    .feature_3(feature_3),
    .sa_reg_en(sa_reg_en),
    .sa_en(sa_en),
    .preload_weight_1(preload_weight_1),
    .preload_weight_2(preload_weight_2),
    .preload_weight_3(preload_weight_3),
    .preload_weight_4(preload_weight_4),
    .preload_weight_5(preload_weight_5),
    .preload_weight_6(preload_weight_6),
    .preload_weight_7(preload_weight_7),
    .preload_weight_8(preload_weight_8),
    .preload_weight_9(preload_weight_9),
    .preload_ens(preload_ens)
);
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        rst = 1;
        Weight_Preloader_en = 0;
        Feature_Loader_en = 0;
        feature_baseaddr = 0;
        mode = 0;

        #50 rst = 0;
        #10 mode = 0; Weight_Preloader_en = 1;
        wait(is_WL_done_o == 1'b1);
        @(posedge clk);
            #1 mode = 1; Weight_Preloader_en = 0; Feature_Loader_en = 1; feature_baseaddr = 6'b00_1001;
        wait(is_FL_done_o == 1'b1);
        @(posedge clk);
            #1 feature_baseaddr = 6'b00_1010;
    end
endmodule