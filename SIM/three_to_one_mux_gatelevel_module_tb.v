module three_to_one_mux_tb;
    reg a;
    reg b;
    reg c;
    reg s0;
    reg s1;
    wire out;

    three_to_one_mux_gatelevel_module inst_0(.a(a), .b(b), .c(c), .s0(s0), .s1(s1), .out(out)); //test

    initial begin
            
            a = 0; b = 0; c = 0; s0 = 0; s1 = 0;
            
        #10 s1 = 0; s0 = 0;
        #10 a = 1;
        #10 a = 0;
        #10 a = 1;
        
        #10 s1 = 0; s0 = 1;
        #10 b = 1; 
        #10 b = 0;
        #10 b = 1;
        
        #10 s1 = 1; s0 = 0;
        #10 c = 1;
        #10 c = 0;
        #10 c = 1;
        
        #10 s1 = 1; s0 = 1;
        #10 c = 1;
        #10 c = 0;
        #10 c = 1;
    end
endmodule