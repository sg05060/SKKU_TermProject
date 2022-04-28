module sub(x, y, b_in, out, b_out);

    input x, y;
    input b_in;
    output out, b_out;

assign out = (!x&!y&b_in) || (!x&y&!b_in) || (x&!y&!b_in) || (x&y&b_in);
assign b_out = (!x&!y&b_in) || (!x&y&!b_in) || (!x&y&b_in) || (x&y&b_in);

endmodule
