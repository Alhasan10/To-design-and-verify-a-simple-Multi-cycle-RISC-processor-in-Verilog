module clock (clk);
	output reg clk;
	
	initial begin
        clk = 0; // Initialize the clock signal
    end
    
    always #10 begin
        clk = ~clk; // Toggle the clock every 5 ns for a 10 ns period
    end	 
	
endmodule
		