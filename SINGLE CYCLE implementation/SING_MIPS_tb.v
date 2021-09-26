`timescale 1ns/1ns

module MIPS_tb;

	reg clk;
    reg rst;

	MIPS DUT (.clk(clk),.rst(rst));

    always #50 clk=!clk;

	initial begin
      
      $dumpfile("dump.vcd"); $dumpvars;
      
	clk=0;
	rst=1;
	#100; 
      repeat(10) begin
	rst=0;
	#100;
      end
      $finish;
  	end
 

endmodule