module mux4x1 (in1, in2, in3,in4, out, sel);

  input [15:0] in1, in2, in3,in4;
input [1:0] sel;
output reg [15:0] out;


    always @(*)
    begin
        if(sel == 2'b00)
        out = in1;
        else if (sel == 2'b01)
        out = in2;
        else if (sel == 2'b10)
        out = in3;
      else if(sel == 2'b11)
        out = in4;

    end


endmodule