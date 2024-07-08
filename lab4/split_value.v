module split_value(value, first_segment, second_segment);

// Idea is to seperate the second and first digits in decimal form 
// so that I can then easily decode the two "Single Digit Numbers" 
// into two seven segment displays easily
	input [4 : 0] value;
	output reg [3 : 0] second_segment;
	output reg [3 : 0] first_segment;	
	reg holder;
	always @(value)
		begin
			first_segment = value % 10;
			second_segment = (value - (value % 10)) / 10;
		end
    	 
endmodule