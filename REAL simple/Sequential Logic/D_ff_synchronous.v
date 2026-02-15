module D_ff_synchronous(
	input		i_clk,
	input		i_rst,
	input		i_d,
	output	reg	o_q
);
			
	always @(posedge i_clk) begin
		if(i_rst)	o_q <= 1'b0;
		else 		o_q <= i_d;
	end

endmodule
