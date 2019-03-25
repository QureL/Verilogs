module adder_1bit(
	input i1,
	input i2,
	input cn,
	output result,
	output cn_out
);
assign cn_out=(i1&i2)|(cn&i1)|(cn&i2);
assign result=(i1&(~cn_out))|(i2&(~cn_out))|(cn&(~cn_out))|(i1&i2&cn);
endmodule