/*
   CS/ECE 552 Spring '22

   Filename        : fetch.v
   Description     : This is the module for the overall fetch stage of the processor.
*/
`default_nettype none
module fetch (In, clk, rst, inst, HALT, alignError, Stall, CacheHit, Done);

   // TODO: Your code here
   input wire [15:0] In;
   input wire clk, rst, HALT;
   output wire [15:0] inst;
   output wire alignError, Stall, CacheHit, Done;

   stallmem INSTMEM0(.DataOut(inst), .Done(Done), .Stall(Stall), .CacheHit(CacheHit), .err(alignError), .Addr(In),
        .DataIn(16'h0), .Rd(1'b1), .Wr(1'b0), .createdump(HALT), .clk(clk), .rst(rst));

endmodule
`default_nettype wire
