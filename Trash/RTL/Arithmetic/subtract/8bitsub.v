module subtractor(

    input [7:0] x,
    input [7:0] y,
    input b_in,
    
    output [7:0] out,
    output b_out
);

    wire [6:0] b;       

    sub sub0(.x(x[0]), .y(y[0]), .b_in(b_in), .out(out[0]), .b_out(b[0]));
    sub sub1(.x(x[1]), .y(y[1]), .b_in(b[0]), .out(out[1]), .b_out(b[1]));
    sub sub2(.x(x[2]), .y(y[2]), .b_in(b[1]), .out(out[2]), .b_out(b[2]));
    sub sub3(.x(x[3]), .y(y[3]), .b_in(b[2]), .out(out[3]), .b_out(b[3]));
    sub sub4(.x(x[4]), .y(y[4]), .b_in(b[3]), .out(out[4]), .b_out(b[4]));
    sub sub5(.x(x[5]), .y(y[5]), .b_in(b[4]), .out(out[5]), .b_out(b[5]));
    sub sub6(.x(x[6]), .y(y[6]), .b_in(b[5]), .out(out[6]), .b_out(b[6]));
    sub sub7(.x(x[7]), .y(y[7]), .b_in(b[6]), .out(out[7]), .b_out(b_out));

endmodule
