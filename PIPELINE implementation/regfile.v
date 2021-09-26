`timescale 1ns/1ns

module registerfile(input clk,input wen,input rst,input [4:0] rr1,input [4:0] rr2,input [4:0] wr,input [31:0] wd,output [31:0] rd1,output [31:0] rd2); 
                                     
reg [31:0] register [31:0];

assign rd1 = register[rr1];
assign rd2 = register[rr2];

integer i;

initial begin
    for (i=1; i<32; i=i+1) begin
         register[i] <= 32'd0;
        end
    end
    
always @(posedge clk)
begin
    register[0]=0;
    if(rst) for(i = 0; i < 32; i = i + 1) register[i] = 32'd0;
    else if (wen)
        if(wr != 0) register[wr]= wd;
    
end

endmodule