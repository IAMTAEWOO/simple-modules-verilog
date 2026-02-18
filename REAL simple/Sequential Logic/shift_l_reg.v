module shift_l_reg #(
	parameter WIDTH = 8
)(
	input				i_clk,
	input				i_rst_n,
	input				i_en,
	input				i_in,
	output	reg	[WIDTH-1:0]	o_q
);

	always @(posedge i_clk or negedge i_rst_n) begin
		if(!i_rst_n)
			o_q <= 0;
		else if (i_en)
			o_q <= {o_q[WIDTH-2:0], i_in}; 
	end

endmodule
