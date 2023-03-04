/*
   CS/ECE 552 Spring '22

   Filename        : memory.v
   Description     : This module contains all components in the Memory stage of the
                     processor.
*/
`default_nettype none
module memory (aluRsltIn, memIn, memOut, clk, rst, halt, alignErrorMem, ctrl, InPC, PCImm, PC2, Stall, CacheHit, Done);
    output wire [15:0] memOut, InPC;
    output wire alignErrorMem, CacheHit, Stall, Done;
    input wire [15:0] memIn, aluRsltIn, ctrl, PCImm, PC2;
    input wire clk, rst, halt;

    wire memReadorWrite, memRead, memWrite, jump, branch;
    wire [15:0] nextPC;
    assign memRead = ctrl[3];
    assign memWrite = ctrl[4];
    assign jump = ctrl[6];
    assign branch = ctrl[7];
    assign memReadorWrite = memWrite | memRead;
    assign nextPC = branch ? PCImm : PC2;
    assign InPC = jump ? PCImm : nextPC;

    stallmem DATAMEM0(.DataOut(memOut), .Done(Done), .Stall(Stall), .CacheHit(CacheHit), .err(alignErrorMem), .Addr(aluRsltIn),
                      .DataIn(memIn), .Rd(memRead), .Wr(memWrite), .createdump(halt), .clk(clk), .rst(rst));
endmodule
`default_nettype wire
