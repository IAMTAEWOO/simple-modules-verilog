module mux(
	input		i_0,
	input		i_1,
	input		i_sel,
	output		o_y
	)

	assign o_y = i_sel? i_0 : i_1;

endmodule
