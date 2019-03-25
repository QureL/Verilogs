module flow_led(
    input sys_clk50,
    input rst_n,  //n低电平有效 
    output reg [3:0] led
);
reg [23:0] cnt;
always @(posedge sys_clk50,negedge rst_n)//计数器
begin
if(!rst_n)
    cnt<=1'b0;
    
else 
    if(cnt<24'd10000000)
        cnt<=cnt+1'b1;
    else
        cnt<=24'b0;
    
end
always @(posedge sys_clk50,negedge rst_n)
begin 
	if(!rst_n )
		led <= 4'b0001;
	else
		if(cnt==24'd10000000)
        led<={led[2:0],led[3]};
		else
			led<=led;
end	
endmodule