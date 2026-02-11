module top (
  input         CLOCK_40,
  input         RESET,  
  // // TBD
  // input   [2:0] BUTTON,
  // input   [9:0] SW,
  // output  [6:0] HEX3_D,
  // output  [6:0] HEX2_D,
  // output  [6:0] HEX1_D,
  // output  [6:0] HEX0_D,
  // output  [9:0] LEDR,

  output        UART_TXD,
  input         UART_RXD
);

  parameter CLOCK_FREQ = 40_000_000;
  parameter BAUD_RATE = 115_200;

  reg  [3:0] reset_ff;

  wire clk;
  wire rst_n;
  assign clk = CLOCK_40;

  always @(posedge clk)
    reset_ff <= {reset_ff[2:0], ~RESET};

  assign rst_n = reset_ff[3];

  wire buf_dout_valid;
  wire [7:0] buf_dout;

  wire [7:0] src1;
  wire [7:0] src2;
  wire [4:0] operator;
  wire [3:0] data_type;
  wire parser_done;

  wire [7:0] calc_res;
  wire alu_done;

  wire uin_ready;
  wire [7:0] uart_out;
  wire uart_valid;

  uart_wrap # (
    .CLOCK_FREQ (CLOCK_FREQ) ,
    .BAUD_RATE  (BAUD_RATE)
  ) u_uart ( 
    .clk        (clk),
    .reset      (~rst_n),

    .DataIn       (uart_out),
    .DataIn_valid (uart_valid),
    .DataIn_ready (uin_ready),

    .DataOut       (buf_dout),
    .DataOut_valid (buf_dout_valid),
    .DataOut_ready (),

    .uart_rx    (UART_RXD),
    .uart_tx    (UART_TXD) 
  );

  decoder decoder(
    .clk (clk),
    .n_rst (rst_n),
    .dout_valid (buf_dout_valid),
    .data (buf_dout),
        
    .src1 (src1),
    .src2 (src2),
    .operator (operator),
    .data_type (data_type),
    .parser_done (parser_done)
  );

  alu alu(
    .clk (clk),
    .n_rst (rst_n),

    .parser_done (parser_done),
    .src1 (src1),
    .src2 (src2),
    .dtype(data_type),
    .operator (operator),
    
    .calc_res (calc_res),
    .alu_done (alu_done)
  );

  encoder encoder(
    .clk (clk),
    .n_rst (rst_n),

    .uin_ready (uin_ready),
    .alu_done(alu_done),
    .result (calc_res),

    .uart_out (uart_out),
    .uout_valid (uart_valid)
  );

endmodule
