module eight_bit_full_adder_module_tb;
    reg [7:0] a, b;
    reg cin;
    wire [7:0] sum;
    wire cout;
    
    integer i, j, k;
    
    eight_bit_full_adder_module FA8_0 (.a(a), .b(b), .cin(cint), .sum(sum), .cout(cout));
        
    initial begin
        
        for (i = 0; i < 256; i = i + 1); begin
            #10 a = i;
            for (j = 0; j < 256; j = j + 1) begin
                #10 b = j;
                for (k = 0; k < 2; k = k + 1) begin
                    #10 a = k;
                end
            end
        end
        
endmodule