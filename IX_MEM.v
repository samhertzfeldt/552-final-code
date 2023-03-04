module IX_MEM(IX_ctrl, IX_readD2, IX_PC2, IX_addRslt, IX_aluRslt,
              Stall, ctrl, addRslt, aluRslt, readD2, PC2, clk, rst);

  input clk, rst, Stall;
  input [15:0] IX_ctrl, IX_readD2, IX_PC2, IX_addRslt, IX_aluRslt;
  output [15:0] ctrl, addRslt, aluRslt, readD2, PC2;

  reg_16 REGICTRL(.en(~Stall), .clk(clk), .rst(rst), .d(IX_ctrl), .q(ctrl));
  reg_16 REGreadD2(.en(~Stall), .clk(clk), .rst(rst), .d(IX_readD2), .q(readD2));
  reg_16 REGPC2(.en(~Stall), .clk(clk), .rst(rst), .d(IX_PC2), .q(PC2));
  reg_16 REGaddRslt(.en(~Stall), .clk(clk), .rst(rst), .d(IX_addRslt), .q(addRslt));
  reg_16 REGaluRslt(.en(~Stall), .clk(clk), .rst(rst), .d(IX_aluRslt), .q(aluRslt));

endmodule
