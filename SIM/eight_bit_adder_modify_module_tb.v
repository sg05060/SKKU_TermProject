module eight_bit_adder_modify_module_tb;
    reg [7:0] a, b;
    wire [7:0] sum;
    wire cout;
    
    integer i, j;
    
    eight_bit_adder_modify_module A8_M_0 (.a(a), .b(b), .sum(sum), .cout(cout));
    
    initial begin
        
        for (i = 0; i < 256; i = i + 1); begin
            #10 a = i;
            for (j = 0; j < 256; j = j + 1) begin
                #10 b = j;
            end
        end
        
endmodule