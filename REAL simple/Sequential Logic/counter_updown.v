module counter_updown #(
	parameter WIDTH = 8
)(
	input				i_clk,
	input				i_rst_n,
	input				i_up,
	output	reg	[WIDTH-1:0]	o_cnt
);
	always @(posedge i_clk or negedge i_rst_n) begin
		if(!i_rst_n)
			o_cnt <= {WIDTH{1'b0}};
		else if (i_up)
			o_cnt <= o_cnt + 1'b1 ;
		else
			
			o_cnt <= o_cnt - 1'b1 ;
	end

endmodule
