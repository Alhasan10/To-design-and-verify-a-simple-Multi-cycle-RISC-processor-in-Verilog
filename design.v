//module dataPath(clk); 
	
module dataPath();
	initial begin
		#0
		#800
		$finish;
		end

  //input wire clk;
  wire clk;
  
  reg [2:0] stage_num; // Stage number	
  
  // Define enable signals for each stage
  wire enable_IF, enable_ID, enable_EX, enable_MEM, enable_WB;
  
  
  // For IF stage
  wire [15:0] Instruction,Instruction1,newPC,nextPC;
  wire [1:0] PCSrc;
  wire [15:0] PC;

  // For ID stage
  wire [15:0] BusA,BusB,Imm16,Btarget,jumpTaregt,BusA2,BusB2,Imm16_2;
  wire [3:0] opcode;
  wire mode;
  wire [2:0] RD;
  wire [1:0] RAsrc;
  wire RBsrc,regDst,regWr,ExtOp;

  // For Exec stage
  wire [15:0] ALUres,ALUres2;
  wire zero,neg,ALUsrc;

  // For Mem stage
  wire [15:0] dataOut,dataOut3;
  wire Sv_Imm,MemRd,MemWr,ExtOpMem,MemOut;

  // For WB stage
 
  wire [1:0] WBdata;
  reg EN;
 
  
  always @(stage_num)
	  if (stage_num==1)
		  EN=1;
	  else
		  EN=0;
	  
	  clock cc(clk);
  
  mainControl main(opcode,mode,RAsrc,RBsrc,regDst,regWr,ExtOp,ALUsrc,MemRd,MemWr,Sv_Imm,ExtOpMem,MemOut,WBdata);
  PcControl pcCont(opcode,zero,neg,PCSrc);
  
  mux4x1 mux4(newPC, jumpTaregt, Btarget,BusA, nextPC, PCSrc);
  
  PC_register PCC(clk,EN,nextPC,PC);
   	
  IF_Stage fet(clk,enable_IF,PC,Instruction,newPC,EN1);
  d_ff #(16) dff1(clk,enable_IF,Instruction,Instruction1); //Instruction fetch-decode buffer
  ID_stage dec(clk,enable_ID,Instruction1,newPC,opcode,mode,RD,BusA,BusB,Imm16,Btarget,jumpTaregt,RAsrc,RBsrc,regDst,ExtOp);
  //d_ff  #(48) dff2(clk,enable_ID,{BusA,BusB,Imm16},{BusA1,BusB1,Imm16_1}); // instruction decode-execute buffer

  EX_stage exec(clk,enable_EX,BusA,BusB,Imm16,ALUres,zero,neg,opcode,ALUsrc);
  d_ff  #(64) dff3(clk,enable_EX,{BusA,BusB,Imm16,ALUres},{BusA2,BusB2,Imm16_2,ALUres2});// instruction execute-memory buffer

  MEM_stage mem(clk,enable_MEM,BusA2,BusB2,ALUres2,Imm16_2,dataOut,Sv_Imm,MemRd,MemWr,ExtOpMem,MemOut,opcode);
  d_ff  #(16) dff4(clk,enable_MEM,dataOut,dataOut3);//instruction memory-write back buffer

  WB_stage wrb(clk,enable_WB,ALUres2,dataOut3,newPC,RD,WBdata,regDst,regWr,EN1,opcode);
  
  stageControl stageCon(clk,opcode,enable_IF, enable_ID, enable_EX, enable_MEM, enable_WB,stage_num);
    
  

endmodule