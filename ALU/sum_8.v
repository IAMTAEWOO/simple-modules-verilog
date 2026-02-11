// Main module (8-bit version)
module sum_8(
    input clk,
    input n_rst,

    input start,
    input sel,              // 0 for add, 1 for sub
    input [7:0] src1,
    input [7:0] src2,
    output [7:0] result,
    output done
);
    reg start_d;

    assign done = start_d;

    cla_8 cla(
        .sel    (sel),
        .a      (src1),
        .b      (src2),
        .result (result),
        .c_out  ()
    );

    always @(posedge clk or negedge n_rst) begin
        if (!n_rst) 
            start_d <= 1'b0;
        else 
            start_d <= start;
    end
endmodule

// Carry Lookahead Adder module for 8-bit addition and subtraction
module cla_8(
    input sel, // 0 for addition, 1 for subtraction
    input [7:0] a,
    input [7:0] b,
    output [7:0] result,
    output c_out
);
    wire [7:0] b_mod;
    wire c4;

    // Modify b based on sel (Two's complement for subtraction)
    assign b_mod = sel ? ~b : b;
    assign cin = sel;

    cla_4 cla0 (
            .a(a[3:0]),
            .b(b_mod[3:0]),
            .cin(sel),
            .sum(result[3:0]),
            .cout(c4)
            );


    cla_4 cla1 (
            .a(a[7:4]),
            .b(b_mod[7:4]),
            .cin(c4),
            .sum(result[7:4]),
            .cout()
            );

endmodule

// 4bit CLA  module
module cla_4(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output cout
);
        
    wire [3:0] p;
    wire [3:0] g;
    
    assign p = a ^ b;
    assign g = a & b;


    wire [3:0] c;
    
    assign c[0] = cin;
    assign c[1] = g[0] | (p[0] & c[0]);
    assign c[2] = g[1] | (p[1] & c[1]);
    assign c[3] = g[2] | (p[2] & c[2]);
    assign cout = g[3] | (p[3] & c[3]);
   
    assign sum  = p ^ c;

endmodule
