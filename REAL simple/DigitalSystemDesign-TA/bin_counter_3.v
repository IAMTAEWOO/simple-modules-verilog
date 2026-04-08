module bin_counter_3(
    input       i_clk,
    input       i_pr_b,
    input       i_clr_b,
    output  reg  [2:0]  o_q
    );
    
    always @(posedge i_clk or  negedge i_pr_b or negedge i_clr_b)
    begin
        if(!i_pr_b)
            o_q   <=  3'b111;
        else if(!i_clr_b)
            o_q   <=  3'b000;
        else
            begin
            if(o_q == 3'b111)
                o_q   <=  3'b000;
            else
                o_q   <=  o_q + 1;
            end
    end
endmodule
