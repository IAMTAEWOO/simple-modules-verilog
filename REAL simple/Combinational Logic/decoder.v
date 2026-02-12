module decoder(
	input 		i_a
	output	[1:0]	o_y
	);
	assign o_y = i_a ? 1 : 0;
