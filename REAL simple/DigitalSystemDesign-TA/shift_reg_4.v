module shift_reg_4(
    input           i_clk,      // 클럭
    input           i_pr_b,     // 비동기 preset (active-low)
    input           i_clr_b,    // 비동기 clear  (active-low)
    input           i_d_in,     // serial input
    output  reg [2:0]  o_q      // 출력
);

//-----------------------------------------------------------------------------
// Shift Register 동작
//-----------------------------------------------------------------------------
always @(posedge i_clk or negedge i_pr_b or negedge i_clr_b)
begin
    // 비동기 preset
    if (!i_pr_b)
        o_q <= 3'b111;

    // 비동기 clear
    else if (!i_clr_b)
        o_q <= 3'b000;

    // Shift left (LSB로 입력 들어옴)
    else
        o_q <= {o_q[1:0], i_d_in};
end

endmodule
