module acc_test(
    input clk,
    input [7:0] w_out,
    input [7:0] f_out,
    input rst,
    input en,
    output reg [7:0] out
);

    always @(posedge clk) begin
        if(rst == 1'b1) begin
            out <= 8'b0;
        end
        else if(en == 1'b1) begin
            out <= out + (w_out * f_out);
        end
    end
endmodule