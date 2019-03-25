module test(
	input [2:0] a,
	input [2:0] b,
	output reg [3:0] out
);
always @( * )begin
	out=a+b;
end

endmodule