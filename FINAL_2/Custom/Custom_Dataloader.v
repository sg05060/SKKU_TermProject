module Custom_Data_Loader(
    
    // basic signal
    input           clk,
    input           rst,
    input           en,
    
    // data value and done signal
    input   [7:0]   mem_data_i,
    
    output          is_done_o,
    output  [5:0]   addr_o,
    
    // control signal
    output  [7:0]   demux_sel_o,
    output  [3:0]   acc_en_o,
    output  [3:0]   weight_en_o,
    output  [3:0]   feature_en_o,
    
    output  [7:0]   mem_data_o,
    output  [3:0]   buff_use_o
);

    //  counter and decoder port
    wire    [7:0]   cnt;
    
    wire    [3:0]   buff_en;
    wire    [3:0]   acc_en;
    wire    [3:0]   buff_use;
    wire    [3:0]   feature_en;
    wire    [3:0]   weight_en;
    wire    [7:0]   demux_sel;
    
    wire            feature_weight_sel;

    // dataflow(in -> counter -> decoder -> buffer, mem -> custom_top)


    // counter
    Scalable_up_counter Counter_inst(
        .clk                    (clk), 
        .rst                    (rst), 
        .en                     (en),
        .i_num_cnt              (8'b0001_1100),     // stage 28 
        .out                    (cnt), 
        .is_done_o              (is_done_o)
    );

    // decoder inst (cnt -> control signal)
    Custom_ACC_en_Decoder Custom_ACC_en_dec_inst(                       .cnt(cnt), .acc_en(acc_en) );
    Custom_Buff_use_Decoder Custom_Buff_use_dec_inst(                   .cnt(cnt), .buff_use(buff_use) );
    Custom_Addr_Decoder Custom_Addr_dec_inst(                           .cnt(cnt), .addr(addr_o) );
    Custom_Feature_Weight_en_Decoder Custom_F_W_en_dec_inst(            .cnt(cnt), .buff_en(buff_en) );
    Custom_Feature_Weight_en_SEL_Decoder Custom_F_W_en_sel_dec_inst(    .cnt(cnt), .feature_weight_en_sel(feature_weight_sel) );
    
    
    // demux selection control bit generator
    Demux_SEL Custom_Demux_sel_inst(
        .clk                    (clk),
        .rst                    (rst),
        .buff_use               (buff_use),
        .custom_demux_sel       (demux_sel)
    );
    
    
    // selecting feature or weight update signal
    four_bit_one_to_two_demux_module four_bit_one_to_two_demux_inst(
        .a                      (buff_en),
        .s                      (feature_weight_sel),
        .out1                   (weight_en),
        .out2                   (feature_en)
    );
    

    assign mem_data_o = mem_data_i;     // getting data from mem to one cycle delay
                                        // data_loader_req -> mem(one cycle delay) -> data_loader -> out data and control_sig 
                                        // with same cycle    
    
    // buffering control signal for mem access delay
    eight_bit_d_flip_flop demux_sel_buff( .d(demux_sel), .clk(clk), .q(demux_sel_o), .q_bar() );
    four_bit_d_flip_flop acc_en_buff(       .clk(clk), .d(acc_en),      .q(acc_en_o),       .q_bar() );
    four_bit_d_flip_flop feature_en_buff(   .clk(clk), .d(feature_en),  .q(feature_en_o),   .q_bar() );
    four_bit_d_flip_flop weight_en_buff(    .clk(clk), .d(weight_en),   .q(weight_en_o),    .q_bar() );
    four_bit_d_flip_flop buff_use_buff(     .clk(clk), .d(buff_use),    .q(buff_use_o),     .q_bar() );
    
endmodule