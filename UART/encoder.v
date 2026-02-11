module encoder(
    input clk,
    input n_rst,

    input uin_ready,
    input alu_done,
    input [7:0] result,

    output [7:0] uart_out,
    output uout_valid
);
    localparam LAST = 2;

    reg [7:0] buffer;
    reg [7:0] out;
    reg [1:0] step;
    reg enable;

    reg valid_d1;
    reg valid_d2;

    assign uart_out = out;
    assign uout_valid = valid_d1 & !valid_d2;

    always @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            enable   <= 1'b0;
            buffer   <= 8'h00;
            out      <= 8'h00;
            step     <= 2'h0;
            valid_d1 <= 1'b0;
        end

        else if (alu_done) begin
            enable   <= 1'b1;
            buffer   <= result;
            valid_d1 <= 1'b0;
        end

        else if (step == LAST) begin
            enable   <= 1'b0;
            buffer   <= 8'h00;
            out      <= 8'h00;
            step     <= 2'h0;
            valid_d1 <= 1'b0;
        end

        else if (uout_valid) begin
            // 유지
            buffer   <= buffer;
        end

        else if (!uin_ready) begin
            valid_d1 <= 1'b0;
        end

        else if (enable && uin_ready) begin
            case (buffer[7:4]) // 상위 nibble부터 전송
                4'h0: out <= 8'h30;
                4'h1: out <= 8'h31;
                4'h2: out <= 8'h32;
                4'h3: out <= 8'h33;
                4'h4: out <= 8'h34;
                4'h5: out <= 8'h35;
                4'h6: out <= 8'h36;
                4'h7: out <= 8'h37;
                4'h8: out <= 8'h38;
                4'h9: out <= 8'h39;
                4'hA: out <= 8'h41;
                4'hB: out <= 8'h42;
                4'hC: out <= 8'h43;
                4'hD: out <= 8'h44;
                4'hE: out <= 8'h45;
                4'hF: out <= 8'h46;
            endcase

            buffer   <= buffer << 4;
            step     <= step + 1'b1;
            valid_d1 <= 1'b1;
        end

        else begin
            enable   <= 1'b0;
            buffer   <= 8'h00;
            out      <= 8'h00;
            step     <= 2'h0;
            valid_d1 <= 1'b0;
        end
    end

    always @(posedge clk or negedge n_rst) begin
        if (!n_rst)
            valid_d2 <= 1'b0;
        else
            valid_d2 <= valid_d1;
    end
endmodule
