`timescale 1ns/1ns

module sl2(input [31:0] x,output [31:0] y);
            
assign y = x << 2;

endmodule