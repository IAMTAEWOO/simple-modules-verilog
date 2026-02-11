// multiplicandain module (8-bit version)
module divu_8(
    input clk,
    input n_rst,

    input start,
    input [7:0] src1,
    input [7:0] src2,
    output reg [7:0] Q,
    output reg [7:0] R,
    output reg  done
);
    reg [1:0] state;
    
    localparam IDLE = 2'b00,
                CALC = 2'b01,
                RESL = 2'b11;
    
    reg [7:0] dividend;
    reg [7:0] divisor;
    reg [7:0] quoient;
    reg [7:0] remainder;
    reg [3:0] count;
    

    always @(posedge clk or negedge n_rst) begin
   
    if (!n_rst) begin 
            state              <= 0;
            Q                  <= 0;
            R                  <= 0;
            count              <= 0;
            done               <= 0;
            dividend           <= 0;
            divisor           <= 0;
            quoient            <= 0;
            remainder          <= 0;
            end
        else begin 
   case(state)
        
    IDLE : begin
        done <= 0;
        quoient            <= 0;
        remainder          <= 0;
        count              <= 0;
      if(start) begin
           dividend        <= src1;
           divisor         <= src2;
           state           <= CALC;
         end
        end
    CALC : begin       
       if(dividend >= divisor) begin
            dividend <= dividend - divisor;
            quoient  <= quoient + 1;
            end else begin
            state    <= RESL;
            end
          end
    RESL :  begin
        Q       <= quoient;
        R       <= dividend;
        done    <= 1;
        state   <= IDLE;
        end
    endcase
end
end
endmodule
