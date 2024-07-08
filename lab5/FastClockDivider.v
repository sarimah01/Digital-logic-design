module FastClockDivider(input clk, output reg clk_out);
  reg [31:0] counter;
  parameter D = 32'd12500000;

  always @(posedge clk) begin
    counter <= counter + 32'd1;
    if (counter >= (D-1)) begin
      clk_out <= ~clk_out;
      counter <= 32'd0;
    end
  end
endmodule
