module MEM_stage(clk,enable_MEM,BusA,BusB,ALUres,Imm16,dataOut,Sv_Imm,MemRd,MemWr,ExtOpMemory,MemOut,opcode);


  input wire clk,Sv_Imm,MemRd,MemWr,ExtOpMemory,MemOut;
  input wire enable_MEM;
  input wire [15:0] BusA,BusB,ALUres,Imm16;
  output wire [15:0] dataOut;

  input wire [3:0] opcode;

  // Implementation here
  wire [15:0] address, dataIn, MemoryOut, byteOutExt;
  wire [7:0] byteOut;

  mux2x1 mux1(ALUres, BusA, address, Sv_Imm);
  mux2x1 mux2(BusB, Imm16, dataIn, Sv_Imm);

  dataMemory memory(clk, address, dataIn, MemoryOut, MemWr, MemRd);
  assign byteOut = MemoryOut[7:0];

  Extender #(8) Ext(byteOut, byteOutExt, ExtOpMemory);

  mux2x1 mux3(MemoryOut, byteOutExt, dataOut, MemOut);

endmodule