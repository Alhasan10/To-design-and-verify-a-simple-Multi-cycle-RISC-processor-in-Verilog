module stageControl (clk,opcode,enable_IF,enable_ID,enable_EX,enable_MEM,enable_WB,stage_num);
	input clk;
	input [3:0] opcode;
	
	output reg enable_IF,enable_ID,enable_EX,enable_MEM,enable_WB; 
	
	output reg [2:0] stage_num; // Stage number 
	initial begin 
		 stage_num <= 3'b000;
            enable_IF <= 1;  // Start with IF stage enabled
            enable_ID <= 0;
            enable_EX <= 0;
            enable_MEM <= 0;
            enable_WB <= 0;
			end
	
	// Control logic for stage progression
    always @(posedge clk) begin
        
           
			
            case (stage_num)
                3'b000:  // IF Stage  
					
                    if (enable_IF) begin
                        enable_IF <= 0;  // Disable IF stage after it's done
                        enable_ID <= 1;  // Enable ID stage
                        stage_num <= stage_num + 1;  // Move to next stage
                    end
  
                3'b001:  // ID Stage
                    if (enable_ID) begin
                      if (opcode == 4'b1100 || opcode == 4'b1101 || opcode == 4'b1110) begin  // Check for jump opcode
                            enable_ID <= 0;  // Disable ID stage, restart for new instruction
                            enable_IF <= 1;  // Enable IF stage for new instruction
                            stage_num <= 3'b000;
                      end
                      else begin
                            enable_ID <= 0;
                            enable_EX <= 1;
                            stage_num <= stage_num + 1;
                      end
                    end
                
              	 3'b010: //EX Stage
                   if (enable_EX) begin
                     if (opcode >= 4'b1000 && opcode <= 4'b1011) begin
                       enable_EX <= 0;
                       enable_IF <= 1;  // Enable IF stage for new instruction
                       stage_num <= 3'b000;
                     end
                     else if (opcode >= 4'b0000 && opcode <= 4'b0100) begin
                       enable_EX <= 0;
                       enable_WB <= 1;
                       stage_num <= stage_num + 2;
                     end
                     else begin
                       enable_EX <= 0;
                       enable_MEM <= 1;
                       stage_num <= stage_num + 1;
                     end
                   end
                 
                 3'b011: //MEM Stage
                   if (enable_MEM) begin
                     if (opcode == 4'b0111 || opcode == 4'b1111) begin
                       enable_MEM <= 0;
                       enable_IF <= 1;  // Enable IF stage for new instruction
                       stage_num <= 3'b000;
                     end
                     
                     else begin
                       enable_MEM <= 0;
                       enable_WB <= 1;
                       stage_num <= stage_num + 1;
                     end
                   end
                 
                 3'b100: //WB Stage
                   if (enable_WB) begin
                       enable_WB <= 0;
                       enable_IF <= 1;  // Enable IF stage for new instruction
                       stage_num <= 3'b000;
                   end
            endcase
        end
    
  

endmodule