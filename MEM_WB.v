module MEM_WB(MEM_ctrl, MEM_PC2, MEM_addRslt, MEM_aluRslt, MEM_memOut, MEM_InPC,
ctrl, PC2, addRslt, aluRslt, memOut, InPC, Stall, clk, rst);

input clk, rst, Stall;
input [15:0] MEM_ctrl, MEM_PC2, MEM_addRslt, MEM_aluRslt, MEM_memOut, MEM_InPC;
output [15:0] ctrl, PC2, addRslt, aluRslt, memOut, InPC;

reg_16 REGICTRL(.en(~Stall), .clk(clk), .rst(rst), .d(MEM_ctrl), .q(ctrl));
reg_16 REGmemOut(.en(~Stall), .clk(clk), .rst(rst), .d(MEM_memOut), .q(memOut));
reg_16 REGPC2(.en(~Stall), .clk(clk), .rst(rst), .d(MEM_PC2), .q(PC2));
reg_16 REGaddRslt(.en(~Stall), .clk(clk), .rst(rst), .d(MEM_addRslt), .q(addRslt));
reg_16 REGaluRslt(.en(~Stall), .clk(clk), .rst(rst), .d(MEM_aluRslt), .q(aluRslt));
reg_16 REGInPC(.en(~Stall), .clk(clk), .rst(rst), .d(MEM_InPC), .q(InPC));

endmodule
