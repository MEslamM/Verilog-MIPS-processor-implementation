`timescale 1ns/1ns

module MIPS_PP_tb;

	reg clk;
    reg reset;
	
	MIPS_PP DUT (.clk(clk),.reset(reset));

    always #50 clk=!clk;
	initial begin
      
      $dumpfile("dump.vcd"); $dumpvars;
      
	clk=0;
	reset=1;
	#100;
      repeat(10) begin
	reset=0;
	#100;
      end
      $finish;
  	end
 endmodule