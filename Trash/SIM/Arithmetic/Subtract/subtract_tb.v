
module tb;

  reg[7:0] A, B;
  reg C;
  wire[7:0] OUT;
  wire D;

  subtractor  subtract(.x(A), .y(B), .b_in(C), .out(OUT), .b_out(D));

initial 
begin
  A = 8'b00000000; B = 8'b00000000; C = 1'b0;
  #10 A = 8'b00000011; B = 8'b00000001; 

end

endmodule
