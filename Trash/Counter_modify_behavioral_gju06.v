module Counter_modify_behavioral #(
    parameter BIT_CNT = 8
)
(
    input                   clk,
    input                   rstn,
    input                   en,
    input   [BIT_CNT-1:0]   cnt_i,
    
    output  [BIT_CNT-1:0]   cnt_o,
    output                  done_o
);

    localparam  S_IDLE  = 2'b00;
    localparam  S_RUN   = 2'b01;
    localparam  S_DONE  = 2'b10;

    reg [1:0]           state, state_n;
    wire [BIT_CNT-1:0]  cnt_o
    wire done_o, done;


    always @(posedge clk, negedge rstn) begin
        if (!rstn) begin
            state   <= S_IDLE;
        end else begin
            state   <= state_n;
        end
    end


    always @(*) begin
        state_n = state;
        case (state)
            S_IDLE  : if(en) 
                        state_n = S_RUN;
            S_RUN   : if(done) 
                        state_n  = S_DONE;
            S_DONE  : 
                        state_n = S_IDLE;
        endcase
    end

    assign done_o = (state==S_DONE);

    reg [BIT_CNT-1:0] cnt_reg;
    always @(posedge clk, negedge rstn) begin
        if (!rstn) begin
            cnt_reg <= 'd0;
        end else begin
            if (en & (state==S_IDLE)) begin
                cnt_reg <= cnt_i;
            end
        end
    end
    
    assign done = en && (cnt==cnt_reg-1);
    
    reg [BIT_CNT-1:0] cnt
    always @(posedge clk, negedge rstn) begin
        if (!rstn) begin
            cnt <= 'd0;
        end else if (state==S_DONE) begin
            cnt <= 'd0;
        end else if (staet==S_RUN) begin
            cnt <= cnt + 1;
        end        
    end

    assign cnt_o = cnt;

endmodule