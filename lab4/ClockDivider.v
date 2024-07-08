module ClockDivider(cin,cout);

// Taken from the ClockDivider Module Given and modified
// Will give the posedge every second so that the counter can increment on the display

input cin;
output reg cout;

reg[31:0] count = 32'd0;
parameter D = 32'd50000000;

always @(posedge cin)
begin
	if (count == D / 2)
		begin
			count <= 32'd0;
			cout <= ~cout;
		end
	else
		begin
			count <= count + 32'd1;
		end
end

endmodule