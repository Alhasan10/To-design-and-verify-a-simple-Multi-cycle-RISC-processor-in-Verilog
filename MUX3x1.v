module mux3x1 (in1, in2, in3, out, sel);
parameter n=16;
  input [n-1:0] in1, in2, in3;
input [1:0] sel;
  output reg [n-1:0] out;


    always @(*)
    begin
        if(sel == 2'b00)
        out = in1;
        else if (sel == 2'b01)
        out = in2;
        else if (sel == 2'b10)
        out = in3;

    end


endmodule