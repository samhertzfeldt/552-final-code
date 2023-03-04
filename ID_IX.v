module ID_IX(STALL, ID_ctrl, ID_toPC, ID_ALUA, ID_ALUB, ID_inst, ID_readD2, ID_PC2,
            ctrl, toPC, ALUA, ALUB, inst, readD2, PC2, clk, rst);

  input [15:0] ID_ctrl, ID_toPC, ID_ALUA, ID_ALUB, ID_inst, ID_readD2, ID_PC2;
  output [15:0] ctrl, toPC, ALUA, ALUB, inst, readD2, PC2;
  input STALL, clk, rst;


  reg_16 REGICTRL(.en(~STALL), .clk(clk), .rst(rst), .d(ID_ctrl), .q(ctrl));
  reg_16 REGtoPC(.en(~STALL), .clk(clk), .rst(rst), .d(ID_toPC), .q(toPC));
  reg_16 REGALUA(.en(~STALL), .clk(clk), .rst(rst), .d(ID_ALUA), .q(ALUA));
  reg_16 REGALUB(.en(~STALL), .clk(clk), .rst(rst), .d(ID_ALUB), .q(ALUB));
  reg_16 REGINST(.en(~STALL), .clk(clk), .rst(rst), .d(ID_inst), .q(inst));
  reg_16 REGreadD2(.en(~STALL), .clk(clk), .rst(rst), .d(ID_readD2), .q(readD2));
  reg_16 REGPC2(.en(~STALL), .clk(clk), .rst(rst), .d(ID_PC2), .q(PC2));


endmodule
