module lab4 (clk, sw, reset, pause, HEX0, HEX1);


// Will take the counter clock and divider to get the final output
// on the seven segment display based on the value of the counter 
// which is split into two single digit numbers to make it easier to decode

input clk;
input sw;
input reset;
input pause;

wire clk_out;
wire [4 : 0] counter;
wire [3 : 0] first_segment, second_segment;

output [7 : 0] HEX0;
output [7 : 0] HEX1;


reg flash_dp = 1'b0;
wire flash_clk;

// Create a ClockDivider for the rightmost decimal point flash
ClockDivider dp_flash_clk(clk, flash_clk);

always @(posedge flash_clk) begin
    flash_dp <= ~flash_dp;
end

// Modify HEX0 and HEX1 assignments to control the rightmost decimal point
assign HEX0[7] = flash_dp;
//assign HEX1[7] = flash_dp;


ClockDivider cd(clk, clk_out);

countdown dc(clk_out, counter, sw, reset, pause);

split_value sv(counter, first_segment, second_segment);


// Decode Output To Display (Taken from Lab 2 Seven Segment Decoder and modified)

assign HEX0[0] = ~((~first_segment[3] & ~first_segment[2] & first_segment[1] & ~first_segment[0]) | (~first_segment[3] & ~first_segment[2] & first_segment[1] & first_segment[0]) | (~first_segment[3] & first_segment[2] & ~first_segment[1] & first_segment[0]) | (~first_segment[3] & first_segment[2] & first_segment[1] & ~first_segment[0]) | (~first_segment[3] & first_segment[2] & first_segment[1] & first_segment[0]) | (first_segment[3] & ~first_segment[2] & ~first_segment[1] & ~first_segment[0]) | (first_segment[3] & ~first_segment[2] & ~first_segment[1] & first_segment[0]) | (first_segment[3] & ~first_segment[2] & first_segment[1] & ~first_segment[0]) | (first_segment[3] & first_segment[2] & ~first_segment[1] & ~first_segment[0]) | (first_segment[3] & first_segment[2] & first_segment[1] & ~first_segment[0]) | (first_segment[3] & first_segment[2] & first_segment[1] & first_segment[0]) | (~first_segment[3] & ~first_segment[2] & ~first_segment[1] & ~first_segment[0]));
assign HEX0[1] = ~((~first_segment[3] & ~first_segment[2] & ~first_segment[1] & first_segment[0]) | (~first_segment[3] & ~first_segment[2] & first_segment[1] & ~first_segment[0]) | (~first_segment[3] & ~first_segment[2] & first_segment[1] & first_segment[0]) | (~first_segment[3] & first_segment[2] & ~first_segment[1] & ~first_segment[0]) | (~first_segment[3] & first_segment[2] & first_segment[1] & first_segment[0]) | (first_segment[3] & ~first_segment[2] & ~first_segment[1] & ~first_segment[0]) | (first_segment[3] & ~first_segment[2] & ~first_segment[1] & first_segment[0]) | (first_segment[3] & ~first_segment[2] & first_segment[1] & ~first_segment[0]) | (first_segment[3] & first_segment[2] & ~first_segment[1] & first_segment[0]) | (~first_segment[3] & ~first_segment[2] & ~first_segment[1] & ~first_segment[0]));
assign HEX0[2] = ~((~first_segment[3] & ~first_segment[2] & ~first_segment[1] & first_segment[0]) | (~first_segment[3] & ~first_segment[2] & first_segment[1] & first_segment[0]) | (~first_segment[3] & first_segment[2] & ~first_segment[1] & ~first_segment[0]) | (~first_segment[3] & first_segment[2] & ~first_segment[1] & first_segment[0]) | (~first_segment[3] & first_segment[2] & first_segment[1] & ~first_segment[0]) | (~first_segment[3] & first_segment[2] & first_segment[1] & first_segment[0]) | (first_segment[3] & ~first_segment[2] & ~first_segment[1] & ~first_segment[0]) | (first_segment[3] & ~first_segment[2] & ~first_segment[1] & first_segment[0]) | (first_segment[3] & ~first_segment[2] & first_segment[1] & ~first_segment[0]) | (first_segment[3] & ~first_segment[2] & first_segment[1] & first_segment[0]) | (first_segment[3] & first_segment[2] & ~first_segment[1] & first_segment[0]) | (~first_segment[3] & ~first_segment[2] & ~first_segment[1] & ~first_segment[0]));	
assign HEX0[3] = ~((~first_segment[3] & ~first_segment[2] & first_segment[1] & ~first_segment[0]) | (~first_segment[3] & ~first_segment[2] & first_segment[1] & first_segment[0]) | (~first_segment[3] & first_segment[2] & ~first_segment[1] & first_segment[0]) | (~first_segment[3] & first_segment[2] & first_segment[1] & ~first_segment[0]) | (first_segment[3] & ~first_segment[2] & ~first_segment[1] & ~first_segment[0]) | (first_segment[3] & ~first_segment[2] & ~first_segment[1] & first_segment[0]) | (first_segment[3] & ~first_segment[2] & first_segment[1] & first_segment[0]) | (first_segment[3] & first_segment[2] & ~first_segment[1] & ~first_segment[0]) | (first_segment[3] & first_segment[2] & ~first_segment[1] & first_segment[0]) | (first_segment[3] & first_segment[2] & first_segment[1] & ~first_segment[0]) | (~first_segment[3] & ~first_segment[2] & ~first_segment[1] & ~first_segment[0]));
assign HEX0[4] = ~((~first_segment[3] & ~first_segment[2] & first_segment[1] & ~first_segment[0]) | (~first_segment[3] & first_segment[2] & first_segment[1] & ~first_segment[0]) | (first_segment[3] & ~first_segment[2] & ~first_segment[1] & ~first_segment[0]) | (first_segment[3] & ~first_segment[2] & first_segment[1] & ~first_segment[0]) | (first_segment[3] & ~first_segment[2] & first_segment[1] & first_segment[0]) | (first_segment[3] & first_segment[2] & ~first_segment[1] & ~first_segment[0]) | (first_segment[3] & first_segment[2] & ~first_segment[1] & first_segment[0]) | (first_segment[3] & first_segment[2] & first_segment[1] & ~first_segment[0]) | (first_segment[3] & first_segment[2] & first_segment[1] & first_segment[0]) | (~first_segment[3] & ~first_segment[2] & ~first_segment[1] & ~first_segment[0]));
assign HEX0[5] = ~((~first_segment[3] & first_segment[2] & ~first_segment[1] & ~first_segment[0]) | (~first_segment[3] & first_segment[2] & ~first_segment[1] & first_segment[0]) | (~first_segment[3] & first_segment[2] & first_segment[1] & ~first_segment[0]) | (first_segment[3] & ~first_segment[2] & ~first_segment[1] & ~first_segment[0]) | (first_segment[3] & ~first_segment[2] & ~first_segment[1] & first_segment[0]) | (first_segment[3] & ~first_segment[2] & first_segment[1] & ~first_segment[0]) | (first_segment[3] & ~first_segment[2] & first_segment[1] & first_segment[0]) | (first_segment[3] & first_segment[2] & ~first_segment[1] & ~first_segment[0]) | (first_segment[3] & first_segment[2] & first_segment[1] & ~first_segment[0]) | (first_segment[3] & first_segment[2] & first_segment[1] & first_segment[0]) | (~first_segment[3] & ~first_segment[2] & ~first_segment[1] & ~first_segment[0]));
assign HEX0[6] = (~first_segment[3] & ~first_segment[2] & ~first_segment[1]) | (~first_segment[3] & first_segment[2] & first_segment[1] & first_segment[0]) | (first_segment[3] & first_segment[2] & ~first_segment[1] & ~first_segment[0]);
//assign HEX0[7] = 0;

assign HEX1[0] = ~((~second_segment[3] & ~second_segment[2] & second_segment[1] & ~second_segment[0]) | (~second_segment[3] & ~second_segment[2] & second_segment[1] & second_segment[0]) | (~second_segment[3] & second_segment[2] & ~second_segment[1] & second_segment[0]) | (~second_segment[3] & second_segment[2] & second_segment[1] & ~second_segment[0]) | (~second_segment[3] & second_segment[2] & second_segment[1] & second_segment[0]) | (second_segment[3] & ~second_segment[2] & ~second_segment[1] & ~second_segment[0]) | (second_segment[3] & ~second_segment[2] & ~second_segment[1] & second_segment[0]) | (second_segment[3] & ~second_segment[2] & second_segment[1] & ~second_segment[0]) | (second_segment[3] & second_segment[2] & ~second_segment[1] & ~second_segment[0]) | (second_segment[3] & second_segment[2] & second_segment[1] & ~second_segment[0]) | (second_segment[3] & second_segment[2] & second_segment[1] & second_segment[0]));
assign HEX1[1] = ~((~second_segment[3] & ~second_segment[2] & ~second_segment[1] & second_segment[0]) | (~second_segment[3] & ~second_segment[2] & second_segment[1] & ~second_segment[0]) | (~second_segment[3] & ~second_segment[2] & second_segment[1] & second_segment[0]) | (~second_segment[3] & second_segment[2] & ~second_segment[1] & ~second_segment[0]) | (~second_segment[3] & second_segment[2] & second_segment[1] & second_segment[0]) | (second_segment[3] & ~second_segment[2] & ~second_segment[1] & ~second_segment[0]) | (second_segment[3] & ~second_segment[2] & ~second_segment[1] & second_segment[0]) | (second_segment[3] & ~second_segment[2] & second_segment[1] & ~second_segment[0]) | (second_segment[3] & second_segment[2] & ~second_segment[1] & second_segment[0]));
assign HEX1[2] = ~((~second_segment[3] & ~second_segment[2] & ~second_segment[1] & second_segment[0]) | (~second_segment[3] & ~second_segment[2] & second_segment[1] & second_segment[0]) | (~second_segment[3] & second_segment[2] & ~second_segment[1] & ~second_segment[0]) | (~second_segment[3] & second_segment[2] & ~second_segment[1] & second_segment[0]) | (~second_segment[3] & second_segment[2] & second_segment[1] & ~second_segment[0]) | (~second_segment[3] & second_segment[2] & second_segment[1] & second_segment[0]) | (second_segment[3] & ~second_segment[2] & ~second_segment[1] & ~second_segment[0]) | (second_segment[3] & ~second_segment[2] & ~second_segment[1] & second_segment[0]) | (second_segment[3] & ~second_segment[2] & second_segment[1] & ~second_segment[0]) | (second_segment[3] & ~second_segment[2] & second_segment[1] & second_segment[0]) | (second_segment[3] & second_segment[2] & ~second_segment[1] & second_segment[0]));	
assign HEX1[3] = ~((~second_segment[3] & ~second_segment[2] & second_segment[1] & ~second_segment[0]) | (~second_segment[3] & ~second_segment[2] & second_segment[1] & second_segment[0]) | (~second_segment[3] & second_segment[2] & ~second_segment[1] & second_segment[0]) | (~second_segment[3] & second_segment[2] & second_segment[1] & ~second_segment[0]) | (second_segment[3] & ~second_segment[2] & ~second_segment[1] & ~second_segment[0]) | (second_segment[3] & ~second_segment[2] & ~second_segment[1] & second_segment[0]) | (second_segment[3] & ~second_segment[2] & second_segment[1] & second_segment[0]) | (second_segment[3] & second_segment[2] & ~second_segment[1] & ~second_segment[0]) | (second_segment[3] & second_segment[2] & ~second_segment[1] & second_segment[0]) | (second_segment[3] & second_segment[2] & second_segment[1] & ~second_segment[0]));
assign HEX1[4] = ~((~second_segment[3] & ~second_segment[2] & second_segment[1] & ~second_segment[0]) | (~second_segment[3] & second_segment[2] & second_segment[1] & ~second_segment[0]) | (second_segment[3] & ~second_segment[2] & ~second_segment[1] & ~second_segment[0]) | (second_segment[3] & ~second_segment[2] & second_segment[1] & ~second_segment[0]) | (second_segment[3] & ~second_segment[2] & second_segment[1] & second_segment[0]) | (second_segment[3] & second_segment[2] & ~second_segment[1] & ~second_segment[0]) | (second_segment[3] & second_segment[2] & ~second_segment[1] & second_segment[0]) | (second_segment[3] & second_segment[2] & second_segment[1] & ~second_segment[0]) | (second_segment[3] & second_segment[2] & second_segment[1] & second_segment[0]));
assign HEX1[5] = ~((~second_segment[3] & second_segment[2] & ~second_segment[1] & ~second_segment[0]) | (~second_segment[3] & second_segment[2] & ~second_segment[1] & second_segment[0]) | (~second_segment[3] & second_segment[2] & second_segment[1] & ~second_segment[0]) | (second_segment[3] & ~second_segment[2] & ~second_segment[1] & ~second_segment[0]) | (second_segment[3] & ~second_segment[2] & ~second_segment[1] & second_segment[0]) | (second_segment[3] & ~second_segment[2] & second_segment[1] & ~second_segment[0]) | (second_segment[3] & ~second_segment[2] & second_segment[1] & second_segment[0]) | (second_segment[3] & second_segment[2] & ~second_segment[1] & ~second_segment[0]) | (second_segment[3] & second_segment[2] & second_segment[1] & ~second_segment[0]) | (second_segment[3] & second_segment[2] & second_segment[1] & second_segment[0]));
assign HEX1[6] = (~second_segment[3] & ~second_segment[2] & ~second_segment[1]) | (~second_segment[3] & second_segment[2] & second_segment[1] & second_segment[0]) | (second_segment[3] & second_segment[2] & ~second_segment[1] & ~second_segment[0]);
//assign HEX1[7] = 0;

endmodule 