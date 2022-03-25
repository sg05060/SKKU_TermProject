module four_bit_full_adder_module_tb;
    reg [3:0] a, b;
    reg cin;
    wire [3:0] sum; 
    wire cout;
    
    integer i;
    
    four_bit_full_adder_module FA4_0 (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
    
    initial begin
    
        for (i = 0; i < 512; i = i + 1) begin
            #10 {a[3:0], b[3:0], cin} = i;
        end
    end
endmodule