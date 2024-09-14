module tb_PC_register;
    reg clk;
    reg EN;
    reg [15:0] in;
    wire [15:0] out;

    // Instantiate the PC_register module
    PC_register uut (
        .clk(clk),
        .EN(EN),
        .in(in),
        .out(out)
    );

    // Generate clock signal
    always #5 clk = ~clk; // Toggle clock every 5 time units

    initial begin
        // Initialize signals
        clk = 0;
        EN = 0;
        in = 16'b0;

        // Apply test vectors
        #10;
        in = 16'h1234;
        EN = 1;

        #10;
        EN = 0;
        in = 16'h5678;

        #10;
        EN = 1;
        
        #20;
        $stop; // Stop simulation
    end
endmodule
