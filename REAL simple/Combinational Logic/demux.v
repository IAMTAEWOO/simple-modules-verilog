module mux(
	input		i_sel,
	input		i_0,
	output		o_y0,
	output		o_y1,
	)

	assign o_y0 = !(i_sel) ? i_0 : 0 ;
	assign o_y1 =  (i_sel) ? i_0 : 0);
endmodule
