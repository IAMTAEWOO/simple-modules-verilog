module buzzer (
    input        clk,
    input        sw_up,
    input        sw_left,
    input        sw_mid,
    input        sw_right,
    input        sw_down,
    output reg   buzz
);

reg [17:0] cnt;
reg [17:0] div_val;

/*****************************************************
* 버튼 누르면 1 (active high 기준)
*****************************************************/
always @(posedge clk) begin
    if (sw_down)       div_val <= 18'd38221;
    if (sw_left)       div_val <= 18'd34051;
    if (sw_mid)        div_val <= 18'd30336;
    if (sw_right)      div_val <= 18'd25509;
    if (sw_up)         div_val <= 18'd22726;
    if (!(sw_down|sw_left|sw_mid|sw_right|sw_up))
                       div_val <= 18'd0;
end

always @(posedge clk) begin
    if (div_val == 0) begin
        cnt  <= 0;
        buzz <= 0;
    end
    else begin
        if (cnt == div_val) begin
            cnt  <= 0;
            buzz <= ~buzz;
        end
        else
            cnt <= cnt + 1'b1;
    end
end

endmodule
