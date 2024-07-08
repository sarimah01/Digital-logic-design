module lab5 (
  input clk, 
  input SW9, 
  input key, 
  input [1:0] sw, 
  output [9:0] LEDR
);

  reg clk_out;
  wire s_clk_out;
  wire f_clk_out;
  wire [9:0] counter1, counter2, counter3;
  reg [9:0] tmp;

  SlowClockDivider scd(clk, s_clk_out);
  FastClockDivider fcd(clk, f_clk_out);

  always @(posedge SW9 or posedge key) begin
    if (SW9)
      clk_out <= s_clk_out;
    else
      clk_out <= f_clk_out;
  end

  asynccounter #(.N(8)) counter1_inst (
    .clk(clk_out),
    .clr(~key),
    .count(counter1)
  );

  counterTFF #(.N(8)) counter2_inst (
    .clk(clk_out),
    .clr(~key),
    .count(counter2)
  );

  counterBehav #(.N(8)) counter3_inst (
    .clk(clk_out),
    .clr(~key),
    .count(counter3)
  );

  always @(posedge key) begin
    case (sw)
      2'b01: tmp <= counter1;
      2'b10: tmp <= counter2;
      2'b11: tmp <= counter3;
      default: tmp <= 10'b0; // Default case for safety
    endcase
  end

  assign LEDR = tmp;

endmodule

