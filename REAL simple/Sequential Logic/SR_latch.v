module SR_latch(
	input		i_set,
	input		i_rst_n,
	output	reg	o_q
	output	reg	o_q_var
);
	assign	o_q = ~ (i_rst_n | o_q_var);
	assign	o_q_var = ~(i_set | o_q); 
	
endmodule
