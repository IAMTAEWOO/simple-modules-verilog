// multiplicandain module (8-bit version)
module muls_8(
    input clk,
    input n_rst,

    input start,
    input [7:0] src1,
    input [7:0] src2,
    output reg [7:0] product,
    output reg  done
);
    reg [1:0] state;
    
    localparam IDLE = 2'b00,
                CALC = 2'b01,
                SHIF = 2'b10,
                RESL = 2'b11;
    
    reg [15:0] multiplicand;
    reg [8:0] multiplier;
    reg [16:0] acc;
    reg [3:0] count;
    

    always @(posedge clk or negedge n_rst) begin
   
    if (!n_rst) begin 
            state              <= 0;
            acc                <= 0;
            multiplicand       <= 0;
            multiplier         <= 0;
            product            <= 0;
            count              <= 0;
            done               <= 0;
            end
        else begin 
    
case(state)
        
    IDLE : begin
        done <= 0;
        if(start) begin
            acc          <= 0;
            multiplicand <= {8'b0,src1};
            multiplier   <= {src2};
            count        <= 4'd8;
            state        <= CALC;
         end
        end
    CALC : begin       
            case(multiplier[1:0])
            2'b01 : acc <= acc + multiplicand;
            2'b10 : acc <= acc - multiplicand;
            default : acc <= acc;
            endcase
            state       <= SHIF;
            end
          
    SHIF : begin       
            acc         <= {acc[16], acc[16:1]};
            multiplier  <= {acc[0], multiplier[8:1]};
            count <= count - 1;
            if(count ==1)  state <= RESL;
            else           state <= CALC;  

        end
    RESL :  begin
        product <= multiplier[7:0];
        done    <= 1;
        state   <= IDLE;
        end
    endcase
end
end
endmodule
