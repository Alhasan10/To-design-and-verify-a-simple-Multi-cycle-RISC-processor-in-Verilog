module registerFile_tb;
  reg clk;
  reg RegWr;
  reg [2:0] addr1, addr2, addr3;
  reg [15:0] in;
  wire [15:0] out1, out2;

  // Instantiate the register file
  registerFile uut (
    .clk(clk),
    .addr1(addr1),
    .addr2(addr2),
    .addr3(addr3),
    .in(in),
    .out1(out1),
    .out2(out2),
    .RegWr(RegWr)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10-time units period
  end

  // Stimulus
  initial begin
    // Initialize inputs
    RegWr = 0;
    addr1 = 3'b000;
    addr2 = 3'b001;
    addr3 = 3'b000;
    in = 16'h0000;

    // Wait for the global reset
    #10;

    // Read initial values
    addr1 = 3'b001; // Read register 1
    addr2 = 3'b010; // Read register 2
    #10;
    
    // Write a value to register 3
    RegWr = 1;
    addr3 = 3'b011;
    in = 16'h1234;
    #10;
    RegWr = 0;

    // Read the newly written value
    addr1 = 3'b011; // Read register 3
    addr2 = 3'b100; // Read register 4
    #10;

    // Write a value to register 5
    RegWr = 1;
    addr3 = 3'b101;
    in = 16'h5678;
    #10;
    RegWr = 0;

    // Read the newly written value
    addr1 = 3'b101; // Read register 5
    addr2 = 3'b000; // Read register 0
    #10;

    $finish; // End simulation
  end
endmodule
