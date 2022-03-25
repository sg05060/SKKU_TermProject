module eight_bit_adder_modify_module_tb;
    reg [7:0] a, b;
    
    wire [7:0] sum;
    wire cout;
    
    integer i;
    
    eight_bit_adder_modify_module A8_M_0 (.a(a), .b(b), .sum(sum), .cout(cout));
    
    initial begin
        
        a = 8'b0; b = 8'b0;
        
        for (i = 0; i < 256 * 256; i = i + 1) begin
            #10 {a[7:0], b[7:0]} = i;
        end
    end
endmodule