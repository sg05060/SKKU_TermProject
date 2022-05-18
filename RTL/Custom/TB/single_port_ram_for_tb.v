module single_port_ram_for_tb
(
	input [7:0] data,
	input [5:0] addr,
	input we, clk,
	output [7:0] q
);

	// Declare the RAM variable
	reg [7:0] ram[63:0];
	
	// Variable to hold the registered read address
	reg [5:0] addr_reg;
	
	//initialize for test
	integer i;
	initial begin
		ram[0]<= 8'b0000_0001;
		ram[1]<= 8'b0000_0001;
		ram[2]<= 8'b0000_0001;
		
		ram[3]<= 8'b0000_0010;
		ram[4]<= 8'b0000_0010;
		ram[5]<= 8'b0000_0010;
		
		ram[6]<= 8'b0000_0011;
		ram[7]<= 8'b0000_0011;
		ram[8]<= 8'b0000_0011;
		
		ram[9]  <= 8'b0000_0001;
		ram[10] <= 8'b0000_0010;
		ram[11] <= 8'b0000_0011;
		ram[12] <= 8'b0000_0100;
		
		ram[13]  <= 8'b0000_0001;
		ram[14] <= 8'b0000_0010;
		ram[15] <= 8'b0000_0011;
		ram[16] <= 8'b0000_0100;
		
		ram[17]  <= 8'b0000_0001;
		ram[18] <= 8'b0000_0010;
		ram[19] <= 8'b0000_0011;
		ram[20] <= 8'b0000_0100;
		
		ram[21]  <= 8'b0000_0001;
		ram[22] <= 8'b0000_0010;
		ram[23] <= 8'b0000_0011;
		ram[24] <= 8'b0000_0100;
	end
	
	always @ (posedge clk)
	begin
	// Write
		if (we)
			ram[addr] <= data;
		
		addr_reg <= addr;
		
	end
		
	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign q = ram[addr_reg];
	
endmodule
