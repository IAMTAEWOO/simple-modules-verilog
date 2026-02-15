module T_ff(
	input		i_clk
	input		i_t,
	output	reg	o_q
);
	always @(posedge i_clk)	begin
		if(i_t)
			o_q <= ~o_q;
	end

endmodule
