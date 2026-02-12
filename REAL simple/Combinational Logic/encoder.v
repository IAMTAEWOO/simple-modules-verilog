module encoder(
	input 	[1:0]	i_a
	output		o_y
	);
	assign o_y = i_a[1] ? 1 : 0;
