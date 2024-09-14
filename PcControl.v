module PcControl (opcode,zero,negative,PCSrc);

input zero, negative;
input [3:0] opcode;
  output reg [1:0] PCSrc;


  // Always block to determine PCSrc based on inputs
  always @(*) begin
    // Default value
    PCSrc = 0;

    // Control logic based on opcode
    if (opcode == 4'b1000) begin // BGT (opcode 1000)
      if (zero == 0 && negative == 0) // Reg(Rd) > Reg(Rs1)
        PCSrc = 2;
    end else if (opcode == 4'b1001) begin // BLT (opcode 1001)
      if (negative == 1) // Reg(Rd) < Reg(Rs1)
        PCSrc = 2;
    end else if (opcode == 4'b1010) begin // BEQ (opcode 1010)
      if (zero == 1) // Reg(Rd) == Reg(Rs1)
        PCSrc = 2;
    end else if (opcode == 4'b1011) begin // BNE (opcode 1011)
      if (zero == 0) // Reg(Rd) != Reg(Rs1)
        PCSrc = 2;
    end else if (opcode == 4'b1100) begin // JMP (opcode 1100)
      PCSrc = 1;
    end else if (opcode == 4'b1101) begin // CALL (opcode 1101)
      PCSrc = 1;
    end else if (opcode == 4'b1110) begin // RET (opcode 1110)
      PCSrc = 3;
    end	 
  end

endmodule