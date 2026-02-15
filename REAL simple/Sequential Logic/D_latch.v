module D_latch(
	input		i_g,
	input		i_d,
	output	reg	o_q
);
	assign	o_q = (i_g) ? i_d : o_q
endmodule
