/*
   CS/ECE 552 Spring '22

   Filename        : wb.v
   Description     : This is the module for the overall Write Back stage of the processor.
*/
`default_nettype none
module wb (PC2, aluRslt, STALL, memOut, mem_to_reg, PC2ALU, regWrData, InregWrite, OutregWrite, InwriteRegSel, OutwriteRegSel);
    input wire [15:0] aluRslt, memOut, PC2;
    output wire [15:0] regWrData;
    input wire STALL,mem_to_reg, PC2ALU, InregWrite; //branch here is whether or not the branch is taken
    output wire OutregWrite;
    output wire [2:0] OutwriteRegSel;
    input wire [2:0] InwriteRegSel;
    wire [15:0] memALU;

   // TODO: Your code here
   assign OutwriteRegSel = InwriteRegSel;
   assign OutregWrite = ~STALL?InregWrite:0;
   assign memALU = mem_to_reg ? memOut : aluRslt;
   assign regWrData = PC2ALU ?  PC2 : memALU;


endmodule
`default_nettype wire
