module tb_FSM_Serial_mode;
reg clk;
reg rst;
reg i_run_serial_mode;
wire is_done_o;

always  #5 clk = ~clk;
initial begin
    clk = 0;
    rst = 1;
    i_run_serial_mode = 0;

    #100 rst =0;
    @(posedge clk);
        #1 i_run_serial_mode = 1;
    wait(is_done_o==1);
        @(posedge clk);
            #1 i_run_serial_mode = 0;
end
top_FSM_Serial_mode FSM_SERIAL(
    .clk(clk),
    .rst(rst),
    .i_run_serial_mode(i_run_serial_mode),
    .is_done_o(is_done_o)
);
endmodule