module half_adder_gatelevel_module_tb;
    reg a, b;
    wire sum, cout;
    
    half_adder_gatelevel_module HA_0 (.a(a), .b(b), .sum(sum), .cout(cout));
    
    initial begin
            a = 1'b0; b = 1'b0;
        #10 a = 1'b0; b = 1'b1;
        #10 a = 1'b1; b = 1'b0;
        #10 a = 1'b1; b = 1'b1;
    end
endmodule