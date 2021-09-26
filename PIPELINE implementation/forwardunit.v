`timescale 1ns/1ns

module forwardingunit(input [4:0] Rs_EX,input [4:0] Rt_EX,input [4:0] Rs_ID,input [4:0] Rt_ID,            
                      input [4:0] writereg_M,input [4:0] writereg_WB,      
                      input RegWrite_M,input RegWrite_WB,      
                      output reg[1:0] ForwardA_EX,output reg[1:0] ForwardB_EX,
                      output reg ForwardA_ID,output reg ForwardB_ID);

always @(*)
    begin

        //Rs

        if (RegWrite_M && (writereg_M!=0) && (writereg_M==Rs_EX))   // Fwd EXE hazards
            ForwardA_EX=2'b10;

        
        else if (RegWrite_WB && (writereg_WB!=0) && (writereg_WB==Rs_EX))   // Fwd MEM hazards
            ForwardA_EX=2'b01;

        
        else                                                                    // No hazards
            ForwardA_EX=2'b00;

        
         //Rt

        if (RegWrite_M && (writereg_M!=0) && (writereg_M==Rt_EX))           // Fwd EXE hazards
            ForwardB_EX=2'b10;

        
        else if (RegWrite_WB && (writereg_WB!=0) && (writereg_WB==Rt_EX))       // Fwd MEM hazards
            ForwardB_EX=2'b01;

        
        else                                                                   // No hazards
            ForwardB_EX=2'b00;

        ForwardA_ID=(writereg_M!=0) && (Rs_ID==writereg_M) && RegWrite_M; // EXAMPLE FOR ILLUSTRATION RS_D=1,RT_D=1 ;WRITERED_M==ALURESULT_D==0; FWRDAD=0 GO TO "DATAPATH" TO CONTINOUE
        ForwardB_ID=(writereg_M!=0) && (Rt_ID==writereg_M) && RegWrite_M;
     
    end
endmodule