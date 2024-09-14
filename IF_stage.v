module IF_Stage (clk,enable_IF,PC,Instruction,newPC,EN);
  input clk;
  input wire enable_IF;
  input [15:0]PC;
  output reg EN;
  output reg[15:0]newPC;
  output wire[15:0] Instruction;

  
  Pc_Adder pp(PC,newPC);

  instruction_Memory m(PC,Instruction);
  always @(posedge clk)  begin
	  if(enable_IF==1)
		  EN=1;
		  end
endmodule