module jk_flip_flop_behavioral_module (
    input j, k,
    input clk,
    
    output reg q, q_bar
);

    always @(posedge clk) begin
        case ({j, k})
            2'b00: begin q <=  q;   q_bar <=  q_bar;    end
            2'b01: begin q <= 1'b0; q_bar <= 1'b1;      end
            2'b10: begin q <= 1'b1; q_bar <= 1'b0;      end
            2'b11: begin q <= !q;   q_bar <= !q_bar;    end     // when j and k are both 1(high), flip previous output
            default: begin q <= 1'b0; q_bar <= 1'b1;    end     // default then initialize q with zero and q_bar with 1
        endcase
    end
endmodule