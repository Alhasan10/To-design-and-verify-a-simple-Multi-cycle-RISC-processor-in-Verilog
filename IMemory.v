module instruction_Memory (pc,instruction);
  input [15:0] pc;
  output reg [15:0] instruction;
  reg [7:0] Memory [0:255];
  
  initial begin	
	
	// R-Type
	Memory[0] = 8'b0101_0000;// add(4) $R1(3),$R1(3),$R2(3) 
	Memory[1] = 8'b0001_0010;// add(4) $R1(3),$R1(3),$R2(3)    
    
	// S-Type
    Memory[2] = 8'b0111_0000;
    Memory[3] = 8'b1111_0010;   
	
	// R-Type
    Memory[4] = 8'b0001_0110; 
    Memory[5] = 8'b0010_0100;// sub(4) $R1(3),$R1(3),$R2(3) 

	// I-Type 
    Memory[6] = 8'b0110_0100; 
	Memory[7] = 8'b0011_0110; 


end
  
  always @(*) begin
    instruction[7:0] <= Memory [pc];
    instruction [15:8] <= Memory [pc+1];
  end
endmodule 