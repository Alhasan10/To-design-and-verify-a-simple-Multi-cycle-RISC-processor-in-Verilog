module Pc_Adder (pc,out);
input [15:0]pc;
output [15:0] out;

assign out = pc + 2;

endmodule