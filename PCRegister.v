module PC_register (clk, EN, in, out);
  input clk;
  input EN;
  input [15:0] in;
  output reg [15:0] out;

  initial begin
    out = 0;
  end

  always @(posedge clk) begin
    if (EN == 1) begin
      out <= in;
    end
  end
endmodule
