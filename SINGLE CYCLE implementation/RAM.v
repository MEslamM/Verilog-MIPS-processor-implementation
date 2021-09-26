`timescale 1ns/1ns

module ram(clk,wen,adr,din,dout); //wen write enable

parameter depth =128;
parameter bits = 32;
parameter width = 32;

input clk, wen;
input [bits-1:0] adr;
input [width-1:0] din;

output [width-1:0] dout;

reg [width-1:0] Dmem [depth-1:0];
    
assign dout = Dmem[adr];
    
always @ (posedge clk) begin
	
    if (wen) 
		Dmem[adr] <= din;
		 
end

endmodule