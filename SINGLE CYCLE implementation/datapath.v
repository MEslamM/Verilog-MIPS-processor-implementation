`include "adder.v"
`include "ALU.v"
`include "pcrst.v"
`include "MUX.v"
`include "regfile.v"
`include "signextender.v"
`include "shifter.v"

`timescale 1ns/1ns

module Datapath(input clk,input rst,input RegDst,input RegWrite,input ALUSrc,input Jump,input MemtoReg,input PCSrc,input [3:0] ALUControl,input [31:0] ReadData,input [31:0] Instr,output [31:0] PC,output ZeroFlag,output [31:0] WriteData,output [31:0] ALUResult);

wire [31:0] PCNext, PCplus4, PCbeforeBranch, PCBranch;
wire [31:0] extendimm, extendimmafter, MUXresult, dataone, aluop2;
wire [4:0] writereg;

// first PC 

pc_pcnxt #(32) PCregister(clk,rst, PC,PCNext);
adder #(32) pcadd4(PC,32'd4,PCplus4);
sl2 shifteradd2(extendimm,extendimmafter);
adder #(32) pcaddsigned(extendimmafter,PCplus4,PCbeforeBranch);
mux2 #(32) branchmux(PCplus4,PCbeforeBranch,PCSrc,PCBranch);
mux2 #(32) jumpmux(PCBranch,{PCplus4[31:28],Instr[25:0],2'b00},Jump,PCNext);

// seconed Register File 

registerfile RF(clk,RegWrite,rst,Instr[25:21],Instr[20:16],writereg,MUXresult,dataone,WriteData); 
mux2 #(5) writeopmux(Instr[20:16],Instr[15:11],RegDst,writereg);
mux2 #(32) resultmux(ALUResult,ReadData,MemtoReg,MUXresult);

// third ALU

alu alucomp(dataone,aluop2,ALUControl,Instr[10:6],ALUResult,ZeroFlag);
signextend immextention(Instr[15:0],extendimm);
mux2 #(32) aluop2sel(WriteData,extendimm,ALUSrc,aluop2);

endmodule