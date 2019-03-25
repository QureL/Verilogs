module led(
	input sys_clk,
	input sys_rst_n,
	input uart_en,
	output reg[3:0] led_en
);
wire flag;
reg uart_en_d0;
reg uart_en_d1;
assign flag=uart_en_d0&(~uart_en_d1);
reg [23:0] counter;
reg start_flag;

always @(posedge sys_clk,negedge sys_rst_n)begin
	if (!sys_rst_n) begin
        uart_en_d0 <= 1'b0;                                  
        uart_en_d1 <= 1'b0;
    end                                                      
    else begin                                               
        uart_en_d0 <= uart_en;                               
        uart_en_d1 <= uart_en_d0;                            
    end
end
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)begin
        
		  start_flag<=1'b0;
	 end	  
    else if (flag)
        start_flag<=1'b1;
	else if(counter==24'd1000_0000)
		  start_flag<=1'b0;
    else
        start_flag<=start_flag;
		  
end

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        counter <= 24'd0;
    else if (start_flag&&(counter < 24'd1000_0000))
        counter <= counter + 1'b1;
    else
        counter <= 24'd0;
end

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        led_en <= 4'b0000;
	 else if((counter == 24'd0)&&start_flag)
			led_en<=4'b1111;
    else if(counter == 24'd1000_0000) 
        led_en<=4'b0000;
    else
        led_en <= led_en;
end


endmodule