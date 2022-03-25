module four_bit_full_adder_modify_module_tb;
    reg [3:0] a, b;
    wire [3:0] sum; 
    wire cout;
    
    integer i;
    
    four_bit_adder_modify_module A4_M_0 (.a(a), .b(b), .sum(sum), .cout(cout));
    
    initial begin
    
        a = 4'b0; b = 4'b0;
    
        for (i = 0; i < 256; i = i + 1) begin
            #10 {a[3:0], b[3:0]} = i;
        end
    end
endmodule