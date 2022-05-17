module Custom_Data_Loader(
    
    input           run_i,
    input   [4:0]   stage_num_i,
    
    input   [7:0]   mem_data_i,
    output  [7:0]   mem_data_o,
    output  [5:0]   mem_addr,
    
    output  [7:0]   sel_demux,
    
    output  [3:0]   acc_en,
    output  [3:0]   weight_en,
    output  [3:0]   feature_en,
    
    output          is_done_o
);
    // mem data in and out
    wire    [7:0]   mem_data;
    wire    [7:0]   mem_data_o;    
    
    // counter out
    wire    [4:0]   cnt;
    
    acc_en_dec acc_en_dec();
    
    weight_en_dec weight_en_dec();
    
    feature_en_dec feature_en_dec();
    
    mem_addr_dec mem_addr_dec();
    

    assign mem_data = mem_data_i;
    assign mem_data_o = mem_data;

    


endmodule