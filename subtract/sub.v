module sub(X, Y, Bin, out, Bo);

    input X, Y;
    input Bin;
    output out, Bo;

assign out = (!X&!Y&Bin) || (!X&Y&!Bin) || (X&!Y&!Bin) || (X&Y&Bin);
assign Bo = (!X&!Y&Bin) || (!X&Y&!Bin) || (!X&Y&Bin) || (X&Y&Bin);

endmodule
