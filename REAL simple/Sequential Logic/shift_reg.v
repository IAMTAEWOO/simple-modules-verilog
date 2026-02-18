module shift_reg(
	input		i_clk,
	input		i_rst_n,
	input		i_d,
	output		o_d
);
	reg [3:0] r_d;

	always @(posedge i_clk or negedge i_rst_n) begin
		if(!i_rst_n)
			r_d <= 4'b0;
		else
			r_d <= {r_d[2:0], i_d};
	end

	assign o_d = r_d[3];

endmodule
