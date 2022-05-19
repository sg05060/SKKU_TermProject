module top_FSM_Serial_mode(
    input clk,
    input rst,
    input i_run_serial_mode,
    output wire is_done_o
);
    wire is_done_i;
    wire en;
    wire [7:0] feature_baseaddr;
FSM_Serial_mode FSM(
    .clk(clk),
    .rst(rst),
    .i_run_serial_mode(i_run_serial_mode),
    .is_done_i(is_done_i),

    .is_done_o(is_done_o),
    .en(en),
    .feature_baseaddr(feature_baseaddr)
);

top_serial_mode serial_mode(
    .clk(clk),
    .rst(rst),
    .en(en),
    .feature_baseaddr(feature_baseaddr),

    .is_done_o(is_done_i),
    .out()
);
endmodule