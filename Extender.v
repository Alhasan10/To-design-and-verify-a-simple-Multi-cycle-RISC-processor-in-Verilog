module Extender (in,out,ExtOp);
parameter n=16;
  input [n-1:0] in;
input ExtOp;
output reg [15:0] out;

always @(in) begin
if(ExtOp == 1)
	out = {{11{in[4]}},in};
else 
	out = {11'b0,in};
end
endmodule
