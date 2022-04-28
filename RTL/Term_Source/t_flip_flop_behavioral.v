//This is for the T flip flop module.

module t_flip_flop_behavioral_module (t, clk, rst, preset, q, q_bar);
	input t;
	input clk; // clock
	input rst; //reset
	input preset;

	output q, q_bar;
	reg q, q_bar;
	
	always @ (posedge clk or posedge rst)
	begin
		if(rst)
		begin
			if(preset == 1'b1)
			begin
				q <= 1'b1;
				q_bar <= 1'b0;
			end
			else
			begin
				q <= 1'b0;
				q_bar <= 1'b1;
			end
		end
		else
		begin
			if(t == 1'b1)
			begin
				q <= !q;
				q_bar <= !q_bar;
			end
			else
			begin
				q <= q;
				q_bar <= q_bar;
			end
		end
	end
endmodule

