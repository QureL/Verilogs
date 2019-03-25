module first_0321_2(
	input sys_clk,//系统时钟
	input sys_rst_n,//低电平有效的系统复位信号
	output reg[7:0] cnt
);
always @(posedge sys_clk,negedge sys_rst_n) begin//以系统时钟驱动的counter
	if(!sys_rst_n)
		cnt<=0;
	else if(cnt<8'b1111_1111)
		cnt<=cnt+1;
	else if(cnt==8'b1111_1111)
		cnt<=0;
	else
		cnt<=cnt;
end
endmodule