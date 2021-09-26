`timescale 1ns/1ns

module pc_pcnxt(clk, rst,en ,q,d);

parameter n=32;

input clk,rst;
input [n-1:0] d;
input en;

output reg [n-1:0] q;

always @ (posedge clk)

  if(rst) begin
    q<=0;
  end
  else if (!en) begin
   q<=q;
 end
  else begin
    q<=d;
  end
  
endmodule
