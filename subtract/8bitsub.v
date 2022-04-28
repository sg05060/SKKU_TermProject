module subtractor(X, Y, Bin, out, Bo);

    input[7:0] X, Y;
    input Bin;
    output[7:0] out;
    output Bo;
    reg[6:0] B;


    sub sub0(.X(X[0]), .Y(Y[0]), .Bin(Bin), .out(out[0]), .Bo(B[0]));
    sub sub1(.X(X[1]), .Y(Y[1]), .Bin(B[0]), .out(out[1]), .Bo(B[1]));
    sub sub2(.X(X[2]), .Y(Y[2]), .Bin(B[1]), .out(out[2]), .Bo(B[2]));
    sub sub3(.X(X[3]), .Y(Y[3]), .Bin(B[2]), .out(out[3]), .Bo(B[3]));
    sub sub4(.X(X[4]), .Y(Y[4]), .Bin(B[3]), .out(out[4]), .Bo(B[4]));
    sub sub5(.X(X[5]), .Y(Y[5]), .Bin(B[4]), .out(out[5]), .Bo(B[5]));
    sub sub6(.X(X[6]), .Y(Y[6]), .Bin(B[5]), .out(out[6]), .Bo(B[6]));
    sub sub7(.X(X[7]), .Y(Y[7]), .Bin(B[6]), .out(out[7]), .Bo(Bo));

endmodule
