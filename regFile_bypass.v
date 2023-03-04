/*
   CS/ECE 552, Fall '22
   Homework #3, Problem #2

   This module creates a wrapper around the 8x16b register file, to do
   do the bypassing logic for RF bypassing.
*/
module regFile_bypass (
                       // Outputs
                       read1Data, read2Data, err,
                       // Inputs
                       clk, rst, read1RegSel, read2RegSel, writeRegSel, writeData, writeEn
                       );
   parameter NUM_REGISTERS = 7; //num registers -1
   parameter REGISTER_SIZE = 15; // register size = size-1
   parameter BINARY_SELECT = 2; // 2^3 = 8

   input        clk, rst;
   input [BINARY_SELECT:0]  read1RegSel; // select registers 0-7 read port 1
   input [BINARY_SELECT:0]  read2RegSel; // select registers 0-7 read port 2
   input [BINARY_SELECT:0]  writeRegSel; // select registers 0-7 write port
   input [REGISTER_SIZE:0] writeData; // 16 bits of data
   input        writeEn; // enable writing to register

   output [REGISTER_SIZE:0] read1Data; // 16 bits of data read port 1
   output [REGISTER_SIZE:0] read2Data; // 16 bits of data read port 2
   output        err;
   /* YOUR CODE HERE */
   wire [REGISTER_SIZE:0] data1, data2;



   regFile regFile0(.read1Data(data1), .read2Data(data2), .err(err),
                    .clk(clk), .rst(rst), .read1RegSel(read1RegSel), .read2RegSel(read2RegSel), .writeRegSel(writeRegSel), .writeData(writeData), .writeEn(writeEn));



   assign read1Data =  (writeEn&(writeRegSel == read1RegSel))? writeData:data1;
   assign read2Data = (writeEn&(writeRegSel == read2RegSel))? writeData:data2;


endmodule
