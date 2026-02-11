module decoder(
    input clk,
    input n_rst,
    input dout_valid,
    input [7:0] data,
    
    output [7:0] src1,
    output [7:0] src2,
    output [4:0] operator,
    output [3:0] data_type,
    output parser_done
);

    localparam I = 4'h8,
            F = 4'h4,
            U = 4'h2,
            S = 4'h1;
    
    localparam SUM = 5'h10,
            SUB = 5'h08,
            MUL = 5'h04,
            DIV = 5'h02,
            RMD = 5'h01,
        // ADD OP
            AND = 5'h11,
            OR  = 5'h12,
            XOR = 5'h14;

    localparam SPACE = 8'h20,
            END_SYM = 8'h3d,
            ASCII_F = 8'h46;
    
    reg [15:0] src;
    reg [4:0] op;
    reg [3:0] dtype;
    reg delay;
    
    reg done_d1;
    reg done_d2;

    wire done_edge;
    wire buf_dout_valid;
    assign buf_dout_valid = dout_valid & !delay;
    assign done_edge = done_d1 & !done_d2;
    assign src1 = src[15:8];
    assign src2 = src[7:0];
    assign operator = op;
    assign data_type = dtype;
    assign parser_done = done_edge;

    //parsing logic
    always @(posedge clk or negedge n_rst)begin
        if(!n_rst)begin
            src <= 16'b0;
            done_d1 <= 1'b0;
            op <= 4'h0;
            dtype <= 4'h0;
        end

        else if(done_edge)begin
            src <= 16'h0;
            done_d1 <= 1'b0;
            op <= 4'h0;
            dtype <= 4'h0;
        end

        else if(data == SPACE) begin
            src <= src;
            op <= op;
            dtype <= data_type;
        end

        else if(buf_dout_valid) begin
            if (data == ASCII_F) begin
                if(dtype == 4'h0) begin
                    dtype <= dtype | F;
                end

                else begin
                    src <= {src[11:0],4'hf};
                end
            end

            else begin
                case(data)
                    8'h49: dtype <= dtype | I;
                    8'h55: dtype <= dtype | U;
                    8'h53: dtype <= dtype | S;

                    8'h2b: op <= SUM;
                    8'h2d: op <= SUB;
                    8'h2a: op <= MUL;
                    8'h2f: op <= DIV;
                    8'h25: op <= RMD;
                    // ADD OP
                    8'h26: op <= AND;
                    8'h7C: op <= OR ;
                    8'h5E: op <= XOR;

                    8'h30: begin src <= {src[11:0],4'h0}; end
                    8'h31: begin src <= {src[11:0],4'h1}; end
                    8'h32: begin src <= {src[11:0],4'h2}; end
                    8'h33: begin src <= {src[11:0],4'h3}; end
                    8'h34: begin src <= {src[11:0],4'h4}; end
                    8'h35: begin src <= {src[11:0],4'h5}; end
                    8'h36: begin src <= {src[11:0],4'h6}; end
                    8'h37: begin src <= {src[11:0],4'h7}; end
                    8'h38: begin src <= {src[11:0],4'h8}; end
                    8'h39: begin src <= {src[11:0],4'h9}; end
                    8'h41: begin src <= {src[11:0],4'ha}; end
                    8'h42: begin src <= {src[11:0],4'hb}; end
                    8'h43: begin src <= {src[11:0],4'hc}; end
                    8'h44: begin src <= {src[11:0],4'hd}; end
                    8'h45: begin src <= {src[11:0],4'he}; end

                    END_SYM: done_d1 <= 1'b1;

                    default: begin
                        src <= 16'h0;
                        done_d1 <= 1'b0;
                        op <= 4'h0;
                        dtype <= 4'h0;
                    end
                endcase
            end
        end
    end

    //edge detecting
    always @(posedge clk or negedge n_rst)begin
        if(!n_rst)begin
            done_d2 <= 1'b0;
            delay <= 1'b0;
        end
        
        else begin
            done_d2 <= done_d1;
            delay <= dout_valid;
        end
    end
endmodule
