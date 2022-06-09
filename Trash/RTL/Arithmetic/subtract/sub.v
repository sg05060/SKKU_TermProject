module sub(x, y, b_in, out, b_out);

    input x, y;
    input b_in;
    output out, b_out;

    wire not_x, and_1, xnor_1, not_xnor, xnor_2, and_2;

not_gate not_gate1(.a(x), .out(not_x)); 
and_gate and_gate1(.a(not_x), .b(y), .out(and_1)); 
xnor_gate xnor_gate1(.a(x), .b(y), .out(xnor_1));
not_gate not_gate2(.a(xnor_1), .out(not_xnor)); 
and_gate and_gate2(.a(xnor_1), .b(b_in), .out(and_2));
xnor_gate xnor_gate1(.a(b_in), .b(not_xnor), .out(xnor_2));
not_gate not_gate2(.a(xnor_2), .out(out));
or_gate or_gate1(.a(and_2), .b(and_1), .out(b_out));  

endmodule
