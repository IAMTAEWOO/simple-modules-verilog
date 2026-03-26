module demux_1x4(
	input		[1:0]  i_sel,
	input				i_x,
	output				o_y0,
	output				o_y1,
	output				o_y2,
	output				o_y3,
);

  assign o_y0 =  (i_sel  ==  2'b00) ? i_x : 0 ;
  assign o_y1 =  (i_sel  ==  2'b01) ? i_x : 0 ;
  assign o_y2 =  (i_sel  ==  2'b10) ? i_x : 0 ;
  assign o_y3 =  (i_sel) ? i_x : 0 ;

endmodule
