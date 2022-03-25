module eight_bit_full_adder_module_tb;
    reg [7:0] a, b;
    reg cin;
    
    wire [7:0] sum;
    wire cout;
    
    integer i;
    
    eight_bit_full_adder_module FA8_0 (.a(a), .b(b), .cin(cint), .sum(sum), .cout(cout));
        
    initial begin
        
        a = 8'b0; b = 8'b0; cin = 1'b0; 
        
        for (i = 0; i < 256 * 256 * 2; i = i + 1) begin
            #10 {a[7:0], b[7:0], cin} = i;
        end
    end
endmodule