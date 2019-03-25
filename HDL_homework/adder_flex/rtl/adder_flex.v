module adder_flex(
	input rst,
	input clk,
	input in1,
	output out1

);
reg [7:0] cnt;
assign out1=1'b1&cnt[1];
always @(posedge clk,negedge rst)begin
	if(!rst)begin
		cnt<=0;
	end
	else if(cnt<8'hff)
		cnt<=cnt+1;
	else if(cnt >=8'hff)
		cnt<=0;
	else 
		cnt<=cnt;
end


endmodule