module _8bit_adder_reg(
	input sys_clk,
	input sys_rst_n,
	input [7:0] in1,
	input [7:0] in2,
	input cn1,
	output reg enable,
	output [8:0] out
);
reg [7:0] cnt;
wire [7:0] a;
wire [7:0] b;
assign a=cnt&in1;
assign b=cnt&in2;
wire [7:0] connect;
always @(posedge sys_clk,negedge sys_rst_n)begin
	if(!sys_rst_n)begin
		cnt<=8'b0000_0001;
		enable<=0;
	end
	else if(cnt<8'b1000_0000)begin
		cnt<={cnt[6:0],cnt[7]};
	end
	else if(cnt==8'b1000_0000)
		enable<=1;
	else begin
		cnt<=cnt;
		enable<=enable;
	end
end



adder_1bit adder_0(
	.i1 (a[0]),
	.i2 (b[0]),
	.cn (cn1),
	.result (out[0]),
	.cn_out (connect[0]),
);
adder_1bit adder_1(
	.i1 (a[1]),
	.i2 (b[1]),
	.cn (connect[0]),
	.result (out[1]),
	.cn_out (connect[1]),
);
adder_1bit adder_2(
	.i1 (a[2]),
	.i2 (b[2]),
	.cn (connect[1]),
	.result (out[2]),
	.cn_out (connect[2]),
);
adder_1bit adder_3(
	.i1 (a[3]),
	.i2 (b[3]),
	.cn (connect[2]),
	.result (out[3]),
	.cn_out (connect[3]),
);
adder_1bit adder_4(
	.i1 (a[4]),
	.i2 (b[4]),
	.cn (connect[3]),
	.result (out[4]),
	.cn_out (connect[4]),
);
adder_1bit adder_5(
	.i1 (a[5]),
	.i2 (b[5]),
	.cn (connect[4]),
	.result (out[5]),
	.cn_out (connect[5]),
);

endmodule