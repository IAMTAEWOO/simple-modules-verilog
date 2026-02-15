module JK_ff(
	input		i_clk,
	input		i_j,
	input		i_k,
	output	reg	o_q
);
	always @(posedge i_clk)	begin
		case ({i_j, i_k}) 
			2'b00 : o_q <= o_q;
			2'b01 : o_q <= 1'b0;
			2'b10 : o_q <= 1'b1;
			2'b11 : o_q <= ~o_q;
		endcase
	end
endmodule
