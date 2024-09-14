module mainControl(opcode,mode,RAsrc,RBsrc,regDst,regWr,ExtOp,ALUsrc,MemRd,MemWr,Sv_Imm,ExtOpMem,MemOut,WBdata);
input [3:0] opcode;
input mode;
output reg RBsrc,regDst,regWr,ExtOp,ALUsrc,MemRd,MemWr,Sv_Imm,ExtOpMem,MemOut;
  output reg [1:0] RAsrc,WBdata;
always @(*) begin
    case (opcode)
        4'b0000, 4'b0001, 4'b0010: begin // R-type
           RAsrc = 0;
          RBsrc = 0;
          regDst = 0;
          regWr = 1;
          ExtOp = 1'bx;
          ALUsrc = 0;
          MemRd = 0;
          MemWr = 0;
          Sv_Imm = 1'bx;
          ExtOpMem = 1'bx;
          MemOut = 1'bx;
          WBdata = 0;
        end

        4'b0011: begin // I-type ADDI
             RAsrc = 0;
          RBsrc = 1'bx;
          regDst = 0;
          regWr = 1;
          ExtOp = 1;
          ALUsrc = 1;
          MemRd = 0;
          MemWr = 0;
          Sv_Imm = 1'bx;
          ExtOpMem = 1'bx;
          MemOut = 1'bx;
          WBdata = 0;
        end

        4'b0100: begin // I-type ANDI
             RAsrc = 0;
          RBsrc = 1'bx;
          regDst = 0;
          regWr = 1;
          ExtOp = 0;
          ALUsrc = 1;
          MemRd = 0;
          MemWr = 0;
          Sv_Imm = 1'bx;
          ExtOpMem = 1'bx;
          MemOut = 1'bx;
          WBdata = 0;
        end

        4'b0101: begin // I-type LW
             RAsrc = 0;
          RBsrc = 1'bx;
          regDst = 0;
          regWr = 1;
          ExtOp = 1;
          ALUsrc = 1;
          MemRd = 1;
          MemWr = 0;
          Sv_Imm = 1'bx;
          ExtOpMem = 1'bx;
          MemOut = 0;
          WBdata = 1;
        end
      
      4'b0110:begin //LB
        case (mode)
          1'b0: begin //LBU
             RAsrc = 0;
          RBsrc = 1'bx;
          regDst = 0;
          regWr = 1;
          ExtOp = 1;
          ALUsrc = 1;
          MemRd = 1;
          MemWr = 0;
          Sv_Imm = 1'bx;
          ExtOpMem = 0;
          MemOut = 1;
          WBdata = 1;
          end
          
          1'b1: begin //LBS
             RAsrc = 0;
          RBsrc = 1'bx;
          regDst = 0;
          regWr = 1;
          ExtOp = 1;
          ALUsrc = 1;
          MemRd = 1;
          MemWr = 0;
          Sv_Imm = 1'bx;
          ExtOpMem = 1;
          MemOut = 1;
          WBdata = 1;
          end
        endcase
      end
      
        
          4'b0111: begin // I-type SW
            RAsrc = 0;
          RBsrc = 1'bx;
          regDst = 1'bx;
          regWr = 0;
          ExtOp = 1;
          ALUsrc = 1;
          MemRd = 0;
          MemWr = 1;
          Sv_Imm = 0;
          ExtOpMem = 1'bx;
          MemOut = 1'bx;
          WBdata = 1'bx;
        end
      
        
          4'b1000,4'b1001,4'b1010,4'b1011: begin // I-type B
            case (mode)
              1'b0: begin
            RAsrc = 0;
          RBsrc = 1;
          regDst = 1'bx;
          regWr = 0;
          ExtOp = 1'bx;
          ALUsrc = 0;
          MemRd = 0;
          MemWr = 0;
          Sv_Imm = 1'bx;
          ExtOpMem = 1'bx;
          MemOut = 1'bx;
          WBdata = 1'bx;
              end
              
              1'b1: begin
            RAsrc = 2;
          RBsrc = 1;
          regDst = 1'bx;
          regWr = 0;
          ExtOp = 1'bx;
          ALUsrc = 0;
          MemRd = 0;
          MemWr = 0;
          Sv_Imm = 1'bx;
          ExtOpMem = 1'bx;
          MemOut = 1'bx;
          WBdata = 1'bx;
              end
            endcase
        
          end
      4'b1100: begin //JMP
         RAsrc = 1'bx;
          RBsrc = 1'bx;
          regDst = 1'bx;
          regWr = 0;
          ExtOp = 1'bx;
          ALUsrc = 1'bx;
          MemRd = 0;
          MemWr = 0;
          Sv_Imm = 1'bx;
          ExtOpMem = 1'bx;
          MemOut = 1'bx;
          WBdata = 1'bx;
      end
      
       4'b1101: begin //call
         RAsrc = 1'bx;
          RBsrc = 1'bx;
          regDst = 1;
          regWr = 1;
          ExtOp = 1'bx;
          ALUsrc = 1'bx;
          MemRd = 0;
          MemWr = 0;
          Sv_Imm = 1'bx;
          ExtOpMem = 1'bx;
          MemOut = 1'bx;
          WBdata = 2;
      end
      
       4'b1110: begin //Ret
         RAsrc = 1;
          RBsrc = 1'bx;
          regDst = 1'bx;
          regWr = 0;
          ExtOp = 1'bx;
          ALUsrc = 1'bx;
          MemRd = 0;
          MemWr = 0;
          Sv_Imm = 1'bx;
          ExtOpMem = 1'bx;
          MemOut = 1'bx;
          WBdata = 1'bx;
      end
      
       4'b1111: begin //SV
         RAsrc = 0;
          RBsrc = 1'bx;
          regDst = 1'bx;
          regWr = 0;
          ExtOp = 1;
          ALUsrc = 1'bx;
          MemRd = 0;
          MemWr = 1;
          Sv_Imm = 1;
          ExtOpMem = 1'bx;
          MemOut = 1'bx;
          WBdata = 1'bx;
      end


    endcase
end

endmodule
