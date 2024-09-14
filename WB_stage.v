module WB_stage (clk,enable_WB,ALUres,memoryData,nextPC,RW,WBdata,regDst,regWr,EN,opcode);
  input clk, regDst,regWr;
  input wire enable_WB;
  input [1:0] WBdata;
  input [2:0] RW;
  input [15:0] ALUres,memoryData,nextPC;
  output [3:0] opcode;
  output reg EN;
  wire [15:0] BusW,BusA,BusB;
  wire [2:0] addr1,addr2;
  
  wire [2:0] R7=3'b111;
  
  mux3x1 mux1(ALUres, memoryData, nextPC,BusW, WBdata);
     mux2x1 #(3) mux2(rd,R7,RW,regDst);
  registerFile reg1(clk,addr1,addr2,RW,BusW,BusA, BusB,regWr);
 
endmodule