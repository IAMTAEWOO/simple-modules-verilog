module loadable_reg #(
	parameter WIDTH = 8
)(
	input				i_clk,
	input				i_rst_n,
	input				i_load,
	input		[WIDTH-1:0]	i_d,
	output	reg	[WIDTH-1:0]	o_q
);
	always @(posedge i_clk or negedge i_rst_n) begin
		if(!i_rst_n)
			o_q <= {WIDTH{1'b0}};
		else if(i_load)
			o_q <= i_d;
	end

endmodule
