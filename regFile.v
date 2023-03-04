/*
   CS/ECE 552, Fall '22
   Homework #3, Problem #1

   This module creates a 16-bit register.  It has 1 write port, 2 read
   ports, 3 register select inputs, a write enable, a reset, and a clock
   input.  All register state changes occur on the rising edge of the
   clock.
*/
module regFile (
                // Outputs
                read1Data, read2Data, err,
                // Inputs
                clk, rst, read1RegSel, read2RegSel, writeRegSel, writeData, writeEn
                );
   // 8 by 16 register file
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
   wire [REGISTER_SIZE:0] reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8; //number of registers
   wire [REGISTER_SIZE:0] WEreg1, WEreg2, WEreg3, WEreg4, WEreg5, WEreg6, WEreg7, WEreg8;
   wire [REGISTER_SIZE:0] Wreg1, Wreg2, Wreg3, Wreg4, Wreg5, Wreg6, Wreg7, Wreg8;

   mux8_1 mux0(.Sel(read1RegSel),
               .reg1(reg1), .reg2(reg2), .reg3(reg3), .reg4(reg4), .reg5(reg5), .reg6(reg6), .reg7(reg7), .reg8(reg8), .Out(read1Data));

   mux8_1 mux1(.Sel(read2RegSel),
               .reg1(reg1), .reg2(reg2), .reg3(reg3), .reg4(reg4), .reg5(reg5), .reg6(reg6), .reg7(reg7), .reg8(reg8), .Out(read2Data));


   reg_16 reg_16_1(.en(writeEn&writeRegSel ==3'b000),.d(writeData), .clk(clk), .rst(rst), .q(reg1));
   reg_16 reg_16_2(.en(writeEn&writeRegSel ==3'b001), .d(writeData), .clk(clk), .rst(rst), .q(reg2));
   reg_16 reg_16_3(.en(writeEn&writeRegSel ==3'b010), .d(writeData), .clk(clk), .rst(rst), .q(reg3));
   reg_16 reg_16_4(.en(writeEn&writeRegSel ==3'b011), .d(writeData), .clk(clk), .rst(rst), .q(reg4));
   reg_16 reg_16_5(.en(writeEn&writeRegSel ==3'b100), .d(writeData), .clk(clk), .rst(rst), .q(reg5));
   reg_16 reg_16_6(.en(writeEn&writeRegSel ==3'b101), .d(writeData), .clk(clk), .rst(rst), .q(reg6));
   reg_16 reg_16_7(.en(writeEn&writeRegSel ==3'b110), .d(writeData), .clk(clk), .rst(rst), .q(reg7));
   reg_16 reg_16_8(.en(writeEn&writeRegSel ==3'b111), .d(writeData), .clk(clk), .rst(rst), .q(reg8));


endmodule
