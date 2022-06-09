module eight_bit_accumulator_tb;

reg [7:0] in;

reg EN, clk;

reg reset;

wire [7:0] acc;
eight_bit_accumulator uut (.in(in), .clk(clk), .en(EN), .rst(reset), .out(acc) );

initial begin
clk = 1'b0;

 reset <= 1'b1;
 EN=1'b1;

#10 reset<=1'b0;



in = 8'b00000001;

#50 in = 8'b00000010;
      EN=1'b0;
#50 in = 8'b00000011;
#50 EN=1'b1;
end

always #5 clk = ~clk;



endmodule
