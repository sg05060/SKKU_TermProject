module tb_top_sa_loader;
  
    reg clk;
    reg rst;
    reg Weight_Preloader_en;
    reg Feature_Loader_en;
    reg [5:0] feature_baseaddr;
    reg mode;
    reg [2:0] c_sel;

    wire is_FL_done_o;
    wire is_WL_done_o;
    wire [7:0] c11;
    wire [7:0] c12;
    wire [7:0] c21;
    wire [7:0] c22;

    top_sa_loader top_sa_loader(
    .clk(clk),
    .rst(rst),
    .Weight_Preloader_en(Weight_Preloader_en),
    .Feature_Loader_en(Feature_Loader_en),
    .feature_baseaddr(feature_baseaddr),
    .mode(mode),
    .c_sel(c_sel),

    .is_FL_done_o(is_FL_done_o),
    .is_WL_done_o(is_WL_done_o),
    .c11(c11),
    .c12(c12),
    .c21(c21),
    .c22(c22)
    );

    always #5 clk = ~clk;
    initial begin
        clk = 0;
        rst = 1;
        Weight_Preloader_en = 0;
        Feature_Loader_en = 0;
        feature_baseaddr = 0;
        mode = 0;
        c_sel = 2'b00;

        #50 rst = 0;

        #10 mode = 0; Weight_Preloader_en = 1;
        wait(is_WL_done_o == 1'b1);
        @(posedge clk);
            #1 mode = 1; Weight_Preloader_en = 0; Feature_Loader_en = 1; feature_baseaddr = 6'b00_1001; c_sel = 2'b00;

        wait(is_FL_done_o == 1'b1);
        @(posedge clk);
            #1 feature_baseaddr = 6'b00_1010; c_sel = 2'b01;
        
        wait(is_FL_done_o == 1'b1);
        @(posedge clk);
            #1 feature_baseaddr = 6'b00_1101; c_sel = 2'b10;

        wait(is_FL_done_o == 1'b1);
        @(posedge clk);
            #1 feature_baseaddr = 6'b00_1110; c_sel = 2'b11;
    end 

endmodule