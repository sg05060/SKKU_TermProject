module Custom_Ring_Counter_gju06 
(
    input           clk,        // clock
    input           rst,        // positive synchronous clock
    input           en,         // enable
    input   [7:0]   i_num_cnt,  // input count num
    
    output  [7:0]   cnt_o,      // output count num
    output          done_o      // done signal 1 thick when input count num is equal to current count 
);

    wire [7:0] cnt;             // current count that flipflop is latching
    wire [7:0] cnt_n;           // next count that flipflop update when posedge clock
    wire [7:0] add_o;           // add output with current count and 8'b0000_0001
    wire [7:0] xnor_eight_o;    // xnor with current count
    wire and_bitwise_eight_o;   // bitwise eight bit and gate
    wire done;                  // done signal 1 thick when input count num equal to current count
    
    // eight bit register
    eight_bit_register_behavioral_module ff_8(
        .in     (cnt_n), 
        .clk    (clk), 
        .rst    (rst), 
        .out    (cnt)
    );
    
    // add num 1 with current count for counting
    eight_bit_full_adder_module adder_eight_bit_A(
        .a      (cnt), 
        .b      (8'b0000_0001), //! count up add num 1
        .cin    (8'b0000_0000), //! this adder don't need any carry in(can be enhanced)
        .sum    (add_o), 
        .cout   ()              //! carry will be not used
    );
    
    // muxing (current count) and (current count + 1) for enable activation
    eight_bit_two_to_one_mux_gatelevel_module mux_eight_bit_2_to_1_A(
        .a      (cnt), 
        .b      (add_o), 
        .s      (en),           // enable -> update with add output.
        .out    (mux_eight_o)   // Else, latching current count.
    );
    
    // muxing zero and mux_eight_out above for ring counting(ex. 0 -> 1 -> ... i_num_cnt -> 0 -> 1 -> ...)
    eight_bit_two_to_one_mux_gatelevel_module mux_eight_bit_2_to_1_B(
        .a      (mux_eight_o),  // update value with current count plus one
        .b      (8'b0000_0000), // reset value when done.
        .s      (done), 
        .out    (cnt_n)
        );
    
    // checking output is equal or not equal to purpose(i_num_cnt)
    eight_bit_xnor_gate xnor_eight_A(
        .a      (cnt), 
        .b      (i_num_cnt), 
        .out    (xnor_eight_o)
    );
    
    // encoding 8bit num to 1bit num for making done signal
    eight_bit_wise_and_gate and_bitwise_eight_A(
        .a      (xnor_eight_o), 
        .out    (and_bitwise_eight_o)
    );
    
    // prevent when not enable time making done signal
    and_gate and_A(
        .a      (and_bitwise_eight_o), 
        .b      (en), 
        .out    (done)
    );
    
    // assign statement for getting output
    assign cnt_o = cnt;
    assign done_o = done;

endmodule