module mux4(
        input           i_x0,
        input           i_x1,
        input           i_x2,
        input           i_x3,
        input   [1:0]   i_sel,
        output          o_y
);

    assign o_y = (i_sel == 2'b00) ? i_x0 :
                 (i_sel == 2'b01) ? i_x1 :
                 (i_sel == 2'b10) ? i_x2 :
                                     i_x3;

endmodule
