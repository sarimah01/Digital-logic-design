module countdown(clk, counter, sw, reset, pause);

// Will count down form the current max value based on sw 
// and either reset if the reset button is pushed or
// will pause or continue from pressing the pause button

	 input clk;
	 input sw;
	 input reset;
	 input pause;
	 
	 reg enable = 1;
	 reg [4 : 0] max;
	 
	 
	 output reg [4 : 0] counter;
	 
	 initial
		begin
			counter <= 5'd24;
		end
	 always @(*)
		begin	
			max <= (~sw) ? 24 : 30;
		end
	 
	 always @(negedge pause)
		begin
			if (~pause)
				begin
					enable <= ~enable;
				end
		end
    always @(posedge clk or negedge reset)         
		begin
			if(~reset)
				begin
					counter <= max;
				end
			else if(enable & counter > 0)
				begin
					begin
						counter <= counter - 1; 
					end    
				end
		end 
    	 
endmodule

