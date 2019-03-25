module eight_bit_adder_reg(
	input sys_clk,
	input sys_rst_n,
	input [7:0] in1,
	input [7:0] in2,
	input cn1,
	output reg [8:0] results
);
reg [7:0] cnt;
wire [7:0] a;
wire [7:0] b;
assign a=cnt&in1;
assign b=cnt&in2;
wire [7:0] connect;
wire [7:0] out;
reg enable;
reg enable_2;
wire en;
assign en = enable & (~enable_2);//使能信号，读取最后一个时钟的下降沿，保证数据可靠
always @(posedge sys_clk,negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		cnt<=8'b0000_0001;
		enable<=0;
		enable_2<=0;
	end
	else if(cnt<8'hff)begin
		cnt<={cnt[6:0],1'b1};
	end
	else if(cnt==8'hff)begin
		enable<=1;
		enable_2<=enable;//获得一个周期的高电平
	end	
	else begin
		cnt<=cnt;
		enable<=enable;
		enable_2<=enable_2;
	end
end

always @(negedge en)begin
		results<={connect[7],out[7:0]};	
end
//例化五个单位加法器，串联
adder_1bit adder_0(
	.i1 (a[0]),
	.i2 (b[0]),
	.cn (cn1),
	.result (out[0]),
	.cn_out (connect[0])
);
adder_1bit adder_1(
	.i1 (a[1]),
	.i2 (b[1]),
	.cn (connect[0]),
	.result (out[1]),
	.cn_out (connect[1])
);
adder_1bit adder_2(
	.i1 (a[2]),
	.i2 (b[2]),
	.cn (connect[1]),
	.result (out[2]),
	.cn_out (connect[2])
);
adder_1bit adder_3(
	.i1 (a[3]),
	.i2 (b[3]),
	.cn (connect[2]),
	.result (out[3]),
	.cn_out (connect[3])
);
adder_1bit adder_4(
	.i1 (a[4]),
	.i2 (b[4]),
	.cn (connect[3]),
	.result (out[4]),
	.cn_out (connect[4])
);
adder_1bit adder_5(
	.i1 (a[5]),
	.i2 (b[5]),
	.cn (connect[4]),
	.result (out[5]),
	.cn_out (connect[5])
);
adder_1bit adder_6(
	.i1 (a[6]),
	.i2 (b[6]),
	.cn (connect[5]),
	.result (out[6]),
	.cn_out (connect[6])
);
adder_1bit adder_7(
	.i1 (a[7]),
	.i2 (b[7]),
	.cn (connect[6]),
	.result (out[7]),
	.cn_out (connect[7])
);

endmodule