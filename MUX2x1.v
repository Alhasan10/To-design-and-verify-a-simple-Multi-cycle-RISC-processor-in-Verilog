module mux2x1 (in1,in2,out,sel);
  parameter n =16;
  input [n-1:0] in1,in2;
input sel;
  output [n-1:0] out;

assign out = sel? in2:in1;
endmodule 