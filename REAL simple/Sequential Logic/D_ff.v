module D_ff(
	input		i_clk,
	input		i_d,
	output	reg	o_q
);
	always @(posedge i_clk) begin
		o_q <= i_d;
	end

endmodule
