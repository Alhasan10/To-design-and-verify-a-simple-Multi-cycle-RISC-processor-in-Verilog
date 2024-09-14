module registerFile (clk,addr1,addr2,addr3,in,out1, out2,RegWr);
  input clk;
  input RegWr;
  input [2:0] addr1,addr2,addr3;
  input [15:0] in;
  output reg [15:0] out1,out2;
  reg [15:0] register [0:7];
  
  initial begin
     register [0]= 0;
     register [1]= 10;
     register [2]= 15; 
	 register [3]= 0;
     register [4]= 10;
     register [5]= 15;
	 register [6]= 0;
     register [7]= 10;

  end
  
    always @(posedge clk) begin
    out1<= register [addr1];
    out2<= register [addr2];  
	
	   if (RegWr == 1 && addr3 != 0) begin
       register [addr3] <= in;
  end
  end
  

endmodule

  