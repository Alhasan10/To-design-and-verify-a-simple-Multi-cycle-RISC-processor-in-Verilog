module d_ff(clk,EN,D,Q);
  parameter n=16;
  input clk,EN;
  input [n-1:0] D;
  output reg [n-1:0] Q;
  always @(posedge clk)
  	  if(EN==1)
    Q<=D;
  
endmodule