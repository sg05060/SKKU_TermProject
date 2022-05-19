module FSM_Serial_mode(
    input clk,
    input rst,
    input i_run_serial_mode,
    input is_done_i,

    output reg is_done_o,
    output reg en,
    output reg [7:0] feature_baseaddr
);
    parameter S_IDLE = 3'b000;
    parameter S_STRIDE_1 = 3'b001;
    parameter S_STRIDE_2 = 3'b010;
    parameter S_STRIDE_3 = 3'b011;
    parameter S_STRIDE_4 = 3'b100;
    parameter S_WAIT     = 3'b101;
    parameter S_DONE     = 3'b110;

    reg [2:0] next_state;
    reg [2:0] current_state;

    always @(posedge clk) begin
        if(rst == 1) begin
            current_state <= S_IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = S_IDLE;
        case(current_state)
            S_IDLE : if(i_run_serial_mode)
                        next_state = S_STRIDE_1;
                        else
                        next_state = S_IDLE;
            S_STRIDE_1: if(is_done_i)
                        next_state = S_STRIDE_2;
                        else
                        next_state = S_STRIDE_1;
            S_STRIDE_2: if(is_done_i)
                        next_state = S_STRIDE_3;
                        else
                        next_state = S_STRIDE_2;
            S_STRIDE_3: if(is_done_i)
                        next_state = S_STRIDE_4;
                        else
                        next_state = S_STRIDE_3;
            S_STRIDE_4: if(is_done_i)
                        next_state = S_WAIT;
                        else
                        next_state = S_STRIDE_4;
                        
            S_WAIT:     next_state = S_DONE;

            S_DONE:     next_state = S_IDLE;
        endcase
    end

    always @(*) begin
        case(current_state)
            S_IDLE :    begin
                            en = 1'b0;
                            feature_baseaddr = 8'b0;
                            is_done_o = 1'b0;
                        end         

            S_STRIDE_1: begin
                            en = 1'b1;
                            feature_baseaddr = 8'b0000_1001;
                        end 

            S_STRIDE_2: begin
                            en = 1'b1;
                            feature_baseaddr = 8'b0000_1010;
                        end

            S_STRIDE_3: begin
                            en = 1'b1;
                            feature_baseaddr = 8'b0000_1101;
                        end

            S_STRIDE_4: begin
                            en = 1'b1;
                            feature_baseaddr = 8'b0000_1110;
                        end

            S_DONE:     is_done_o = 1'b1;
        endcase
    end

endmodule