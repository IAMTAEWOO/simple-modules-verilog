module D_ff_en(
	input		i_clk,
	input		i_rst_n,
	input		i_en,
	input		i_d,
	output	reg	o_q
);
	always @(posedge i_clk or negedge i_rst_n) begin
		if(!i_rst_n)	
			o_q <= 1'b0;
		else if(i_en)
			o_q <= i_d;
		else
			o_q <= o_q;
	end

endmodule
