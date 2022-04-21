module t_flip_flop_behavioral_module (
    input t,
    input clk,
    
    output reg q, q_bar
);

    always @ (posedge clk) begin
        case (t)
            1'b0: begin q <=  q; q_bar <=  q_bar; end
            1'b1: begin q <= !q; q_bar <= !q_bar; end
            default: begin q <= 1'b0; q_bar <= 1'b1; end // default, then initialize q with zero and q_bar with 1
        endcase
    end
endmodule