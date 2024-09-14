module EX_stage (clk,enable_EX,BusA,BusB,Imm16,ALUres,zero,neg,opcode,ALUsrc);
  input clk;
  input wire enable_EX;
  input [15:0] BusA,BusB,Imm16;
  input ALUsrc;
  input [3:0] opcode;
  output [15:0] ALUres;
  output zero,neg;

  wire [15:0] ALUsrc2;
  mux2x1 #(16) mux(BusB,Imm16,ALUsrc2,ALUsrc);

  ALU alu(BusA,ALUsrc2,opcode,ALUres,zero,neg);

endmodule