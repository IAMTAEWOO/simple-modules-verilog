module OR_gate(
	input 		i_a,
	input		i_b,
	output 		o_y
	);

	assign o_y = i_a > i_b ? 1 : 0; 

endmodule
