`timescale 1ns/1ns

module Controlunit(input [5:0] Opcode,input [5:0] Func,input Zero,output reg MemtoReg,output reg MemWrite,output reg ALUSrc,output reg RegDst,output reg RegWrite,output reg Jump,output PCSrc,output reg [3:0] ALUControl);
               
reg [7:0] cntrlsignals;
reg Branch;
reg Bne;

always @(*) begin 

    case (Opcode) 
        6'b000000: begin                                 // R-type
                    cntrlsignals <= 8'b11000000;        

                    case (Func)
                    6'b100000: ALUControl <= 4'b0000;    // ADD
                    6'b100001: ALUControl <= 4'b0000;    // ADDU
                    6'b100010: ALUControl <= 4'b0001;    // SUB
                    6'b100011: ALUControl <= 4'b0001;    // SUBU
                    6'b100100: ALUControl <= 4'b0010;    // AND
                    6'b100101: ALUControl <= 4'b0011;    // OR
                    6'b100110: ALUControl <= 4'b0100;    // XOR
                    6'b100111: ALUControl <= 4'b1010;    // NOR

                    6'b101010: ALUControl <= 4'b1000;    // SLT
                    6'b101011: ALUControl <= 4'b1001;    // SLTU

                    6'b000000: ALUControl <= 4'b0101;    // SLL
                    6'b000010: ALUControl <= 4'b0110;    // SRL
                    6'b000011: ALUControl <= 4'b0111;    // SRA

                    6'b000100: ALUControl <= 4'b1011;    // SLLV
                    6'b000110: ALUControl <= 4'b1100;    // SRLV
                    6'b000111: ALUControl <= 4'b1101;    // SRAV
                endcase

            end
            
        6'b001000: begin                          // ADDI
                        cntrlsignals <= 8'b10100000;  
                        ALUControl <= 4'b0000; 
                    end  

        6'b001001: begin                          // ADDIU
                        cntrlsignals <= 8'b10100000;  
                        ALUControl <= 4'b0000; 
                    end  

        6'b001100: begin                          // ANDI
                        cntrlsignals <= 8'b10100000;  
                        ALUControl <= 4'b0010; 
                    end 

        6'b001101: begin                          // ORI
                        cntrlsignals <= 8'b10100000;  
                        ALUControl <= 4'b0011; 
                    end  

        6'b001110: begin                          // XORI
                        cntrlsignals <= 8'b10100000;  
                        ALUControl <= 4'b0100; 
                    end       
                    
        6'b001111:  begin                         // LUI
                        cntrlsignals <= 8'b10100000;  
                        ALUControl <= 4'b1110; 
                    end   

        6'b100011: begin                          // LW
                        cntrlsignals <= 8'b10100100;     
                        ALUControl <= 4'b0000;
                    end

        6'b101011: begin                          // SW
                         cntrlsignals <= 8'b00101000;      
                         ALUControl <= 4'b0000;
                    end  

        6'b000100: begin                          // BEQ
                         cntrlsignals <= 8'b00010000;      
                        ALUControl <= 4'b0001; 
                    end      

        6'b000101: begin                          // BNE
                        cntrlsignals <= 8'b00010001;  
                        ALUControl <= 4'b0001; 
                    end

        
        6'b001010: begin                          // SLTI
                        cntrlsignals <= 8'b10100000;  
                        ALUControl <= 4'b1000; 
                    end 

        6'b001011: begin                          // SLTIU
                        cntrlsignals <= 8'b10100000;  
                        ALUControl <= 4'b1001; 
                    end  

        6'b000010: begin                          // J
                        cntrlsignals <= 8'b00000010;  
                        ALUControl <= 4'b0010; 
                    end 
           
        default:   cntrlsignals <= 12'bxxxxxxxxxxxx;      // NOP
    endcase
   

    
    {RegWrite,RegDst,ALUSrc,Branch,MemWrite,MemtoReg,Jump,Bne} = cntrlsignals;

end 

assign PCSrc = Branch & (Zero ^ Bne);

endmodule