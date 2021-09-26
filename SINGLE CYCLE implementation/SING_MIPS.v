`include "datapath.v"
`include "RAM.v"
`include "ROM.v"
`include "control.v"

`timescale 1ns/1ns

module MIPS(input clk,input rst);
                
wire [31:0] PC, Instr, ReadData, WriteData, ALUResult;
wire RegDst, RegWrite, ALUSrc, Jump, MemtoReg, PCSrc, Zero, MemWrite;
wire [3:0] ALUControl;

rom imem(PC,Instr);

Controlunit controlu(Instr[31:26],Instr[5:0],Zero,MemtoReg,MemWrite,ALUSrc,RegDst,RegWrite,Jump,PCSrc,ALUControl);

Datapath datapathcomp(clk,rst,RegDst,RegWrite,ALUSrc,Jump,MemtoReg,PCSrc,ALUControl,ReadData,Instr,PC,Zero,WriteData,ALUResult);

ram dmem(clk,MemWrite,ALUResult,WriteData,ReadData);

endmodule