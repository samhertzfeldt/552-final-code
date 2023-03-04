module IF_ID(IF_inst, IF_PC2, STALL, inst, PC2, clk, rst);
  input STALL, clk, rst;
  input[15:0] IF_inst, IF_PC2;
  output[15:0] inst, PC2;

  reg_16 REGINST(.en(~STALL), .clk(clk), .rst(rst), .d(IF_inst), .q(inst));
  reg_16 REGPC2(.en(~STALL), .clk(clk), .rst(rst), .d(IF_PC2), .q(PC2));

endmodule
