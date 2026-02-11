module alu(
    input clk,
    input n_rst,

    input parser_done,
    input [7:0] src1,
    input [7:0] src2,
    input [3:0] dtype,
    input [4:0] operator,
    
    output [7:0] calc_res,
    output alu_done
);
    //Parameter Define
    localparam I = 4'h8, // Integer
            F = 4'h4,    // Float
            U = 4'h2,    // Unsigned
            S = 4'h1;    // Signed

    localparam SUM = 5'h10,
            SUB = 5'h08,
            MUL = 5'h04,
            DIV = 5'h02,
            RMD = 5'h01,

            AND = 5'h11,
            OR  = 5'h12,
            XOR = 5'h14;


    //registers for calculation
    reg done_reg;
    reg [3:0] r_type;
    reg [4:0] operation;
    reg [7:0] src1_reg;
    reg [7:0] src2_reg;
    reg [7:0] result_reg;

    //start signal define
    reg sum_start;
    reg mul_start;
    reg divs_start;    
    reg divu_start;
    
    //1clk delay registers for generating edge 
    reg sum_start_d;
    reg mul_start_d;
    reg divs_start_d;
    reg divu_start_d;

    //each module's done signal
    wire sum_done;
    wire mul_done;
    wire divu_done;
    wire divs_done;

    //each module's start edge signal
    wire sum_start_edge;
    wire mul_start_edge;
    wire divu_start_edge;
    wire divs_start_edge;

    //result wire
    wire [7:0] SUM_RES;
    wire [7:0] PRODUCT;
    wire [7:0] UQ;
    wire [7:0] UR;
    wire [7:0] SQ;
    wire [7:0] SR;

    //result & done muxing
    assign calc_res = result_reg;
    assign alu_done = done_reg;

    //generate 1clk edges for each module start
    assign sum_start_edge = sum_start && !sum_start_d;
    assign mul_start_edge = mul_start && !mul_start_d;
    assign divs_start_edge = divs_start && !divs_start_d;
    assign divu_start_edge = divu_start && !divu_start_d;

    //operation register keeping it's value until alu done.
    always @(posedge clk or negedge n_rst)begin
        if(!n_rst) operation <= 5'h0;
        else if(parser_done) operation <= operator;
        else if(done_reg) operation <= 5'h0;
        else operation <= operation;
    end

    //r_type regiester keeping it's value until alu done. (for muxing logic)
    always @(posedge clk or negedge n_rst)begin
        if(!n_rst) r_type <= 4'h0;
        else if(parser_done) r_type <= dtype;
        else if(done_reg) r_type <= 4'h0;
        else r_type <= r_type;
    end

    //src[1-2]_reg register keeping it's value until alu done.
    always @(posedge clk or negedge n_rst)begin
        if(!n_rst)begin
            src1_reg <= 8'h0;
            src2_reg <= 8'h0;
        end

        else if(parser_done)begin
            src1_reg <= src1;
            src2_reg <= src2;
        end

        else if(done_reg)begin
            src1_reg <= 8'h0;
            src2_reg <= 8'h0;
        end

        else begin
            src1_reg <= src1_reg;
            src2_reg <= src2_reg;
        end
    end

    //edge detecting logic
    always @(posedge clk or negedge n_rst)begin
        if(!n_rst)begin
            sum_start_d <= 1'b0;
            mul_start_d <= 1'b0;
            divs_start_d <= 1'b0;
            divu_start_d <= 1'b0;
        end

        else begin
            sum_start_d <= sum_start;
            mul_start_d <= mul_start;
            divs_start_d <= divs_start;
            divu_start_d <= divu_start;
        end
    end

    //module muxing logic
    always @(*) begin
        case(operation)
            SUM: begin //SUMATION MODULE CALL
                sum_start = 1'b1;
                mul_start = 1'b0;
                divs_start = 1'b0;
                divu_start = 1'b0;
                done_reg = sum_done;
                result_reg = SUM_RES;
            end

            SUB: begin //SUMATION MODULE CALL
                sum_start = 1'b1;
                mul_start = 1'b0;
                divs_start = 1'b0;
                divu_start = 1'b0;
                done_reg = sum_done;
                result_reg = SUM_RES;
            end

            MUL: begin //MULTIPLIER MODULE CALL
                sum_start = 1'b0;
                mul_start = 1'b1;
                divs_start = 1'b0;
                divu_start = 1'b0;
                done_reg = mul_done;
                result_reg = PRODUCT;
            end

            DIV: begin //DIVIDER MODULE CALL
                if((r_type & S) == S) begin //DIVS CALL
                    sum_start = 1'b0;
                    mul_start = 1'b0;
                    divs_start = 1'b1;
                    divu_start = 1'b0;
                    done_reg = divs_done;
                    result_reg = SQ;
                end

                else begin //DIVU CALL
                    sum_start = 1'b0;
                    mul_start = 1'b0;
                    divs_start = 1'b0;
                    divu_start = 1'b1;
                    done_reg = divu_done;
                    result_reg = UQ;
                end
            end

            RMD: begin //DIVDER MODULE CALL
                if((r_type & S) == S) begin //DIVS CALL
                    sum_start = 1'b0;
                    mul_start = 1'b0;
                    divs_start = 1'b1;
                    divu_start = 1'b0;
                    done_reg = divs_done;
                    result_reg = SR;
                end

                else begin //DIVU CALL
                    sum_start = 1'b0;
                    mul_start = 1'b0;
                    divs_start = 1'b0;
                    divu_start = 1'b1;
                    done_reg = divu_done;
                    result_reg = UR;
                end
            end 
            
            AND: begin //SUMATION MODULE CALL
                sum_start = 1'b0;
                mul_start = 1'b0;
                divs_start = 1'b0;
                divu_start = 1'b0;
                done_reg = 1'b1;
                result_reg = src1_reg & src2_reg;
            end
            
            OR : begin //SUMATION MODULE CALL
                sum_start = 1'b0;
                mul_start = 1'b0;
                divs_start = 1'b0;
                divu_start = 1'b0;
                done_reg = 1'b1;
                result_reg = (src1_reg) | (src2_reg);
            end
            
            XOR : begin //SUMATION MODULE CALL
                sum_start = 1'b0;
                mul_start = 1'b0;
                divs_start = 1'b0;
                divu_start = 1'b0;
                done_reg = 1'b1;
                result_reg = (src1_reg) ^ (src2_reg);
            end
            

            default: begin //Exception Handler
                sum_start = 1'b0;
                mul_start = 1'b0;
                divs_start = 1'b0;
                divu_start = 1'b0;
                done_reg = 1'b0;
                result_reg = 8'h0;
            end
        endcase
    end

    sum_8_rca sum_8( // ADDER BLOCK (8-bit RCA version)
        .clk    (clk),
        .n_rst  (n_rst),
        .start  (sum_start_edge),
        .sel    (!operation[4]),
        .src1   (src1_reg),
        .src2   (src2_reg),
        .result (SUM_RES),
        .done   (sum_done)
    );


    // sum_8 sum_8( //ADDER BLOCK (Based on Carry-Look-Ahead logic)
    //     .clk    (clk),
    //     .n_rst  (n_rst),
    //     .start  (sum_start_edge),
    //     .sel    (!operation[4]),
    //     .src1   (src1_reg),
    //     .src2   (src2_reg),
    //     .result (SUM_RES),
    //     .done   (sum_done)
    // );

    // muls_8 mul_8( //MULTIPLIER BLOCK (Based on Booth Algorithm)
    //     .clk    (clk),
    //     .n_rst  (n_rst),
    //     .start  (mul_start_edge),
    //     .src1   (src1_reg),
    //     .src2   (src2_reg),
    //     .product(PRODUCT),
    //     .done   (mul_done)
    // );

    // divu_8 divu_8( //DIVIDER BLOCK (Based on non-restoring logic)
    //     .clk    (clk),
    //     .n_rst  (n_rst),
    //     .start  (divu_start_edge),
    //     .src1   (src1_reg),
    //     .src2   (src2_reg),
    //     .Q      (UQ),
    //     .R      (UR),
    //     .done   (divu_done)
    // );

    // divs_8 divs_8( //DIVIDER BLOCK (Based on non-restoring logic)
    //     .clk    (clk),
    //     .n_rst  (n_rst),
    //     .start  (divs_start_edge),
    //     .src1   (src1_reg),
    //     .src2   (src2_reg),
    //     .Q      (SQ),
    //     .R      (SR),
    //     .done   (divs_done)
    // );
endmodule
