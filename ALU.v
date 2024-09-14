module ALU (A,B,ALUOp,result,zero,negative);

    input [15:0] A,B;
    input [3:0] ALUOp; // ALU Operation code
    output reg [15:0] result;// ALU Result
    output reg zero; // Zero flag
    output reg negative;

  // ALU Operations
 always @(*) begin

        case (ALUOp)
            4'b0000: result = A & B;  // AND
            4'b0001: result = A + B;  // ADD
            4'b0010: result = A - B;  // SUB
            4'b0011: result = A + B;  // ADDI
            4'b0100: result = A & B;  // ANDI
            4'b0101, // LW
            4'b0110, // LBu, LBs
            4'b0111: result = A + B;  // Address calculation for LW, LBu, LBs, SW

            4'b1000,  // BGT
            4'b1001,  // BLT
            4'b1010,  // BEQ
            4'b1011:  // BNE
                result = A - B; 
            4'b1100, // JMP
            4'b1101, // CALL
            4'b1110: result = A;  // Handling of JMP, CALL and RET should be done outside the ALU
            4'b1111: result = B;  // Sv (Store operation, B is immediate)
            default: result = 16'b0;
        endcase

          zero = (result == 16'b0) ? 1'b1 : 1'b0;
        negative = result[15];

    end
endmodule