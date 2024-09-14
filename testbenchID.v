module test_ID_stage;

  reg clk;
  reg enable_ID;
  reg [15:0] instruction, nextPC;
  reg [1:0] RAsrc;
  reg RBsrc, regDst, regWr, ExtOp;

  wire [3:0] opcode;
  wire [15:0] BusA, BusB, Imm16, BTarget, jumpTarget;
  wire mode;

  // Instantiate the ID_stage module
  ID_stage uut (
    .clk(clk),
    .enable_ID(enable_ID),
    .instruction(instruction),
    .nextPC(nextPC),
    .opcode(opcode),
    .mode(mode),
    .BusA(BusA),
    .BusB(BusB),
    .Imm16(Imm16),
    .BTarget(BTarget),
    .jumpTarget(jumpTarget),
    .RAsrc(RAsrc),
    .RBsrc(RBsrc),
    .regDst(regDst),
    .ExtOp(ExtOp)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    // Initialize inputs
    clk = 0;
    enable_ID = 0;
    instruction = 16'b0000_0111_0110_0000;
    nextPC = 16'b0000_0000_0000_0000;
    RAsrc = 2'b00;
    RBsrc = 0;
    regDst = 0;
    regWr = 0;
    ExtOp = 0;

    // Apply test vectors
    #10;
    enable_ID = 1;
    instruction = 16'b1101_1001_0110_0011; // Example instruction
    nextPC = 16'b0000_0000_0000_0100;
    RAsrc = 2'b01;
    RBsrc = 1;
    regDst = 1;
    regWr = 0;
    ExtOp = 1;

    #20;
    instruction = 16'b0110_0011_0001_1100; // Another example instruction
    nextPC = 16'b0000_0000_0000_1000;
    RAsrc = 2'b10;
    RBsrc = 0;
    regDst = 0;
    regWr = 0;
    ExtOp = 0;

    // Further test vectors can be added here

    #30;
    $stop; // End the simulation
  end

endmodule
