/* $Author: sinclair $ */
/* $LastChangedDate: 2020-02-09 17:03:45 -0600 (Sun, 09 Feb 2020) $ */
/* $Rev: 46 $ */
`default_nettype none
module proc (/*AUTOARG*/
   // Outputs
   err,
   // Inputs
   clk, rst
   );

   input wire clk;
   input wire rst;

   output reg err;

   // None of the above lines can be modified
   wire [15:0] PC, InPC, PC2,  PCtoPCreg;
   wire [15:0] inst, IF_inst, IF_inst2, IF_PC2;
   //ID_REG
   wire [15:0] ID_inst, ID_ctrl, ID_toPC, ID_readD2, ID_ALUA, ID_ALUB, ID_PC2;
   //IX_REG
   wire [15:0] IX_inst, IX_readD2, IX_PC2, IX_addRslt, IX_aluRslt, IX_ctrl;
   //MEM_REG
   wire [15:0] MEM_ctrl, MEM_addRslt, MEM_memOut, MEM_aluRslt, MEM_PC2, MEM_InPC;
   wire [15:0] regWrData, readD2, ALUA, ALUB, toPC, addRslt, aluRslt;
   wire [2:0] InwriteRegSel, OutwriteRegSel;
   wire [15:0] memOut, ctrl;
   //WB_REG
   wire HALT, HALTFetch, flush, mem_to_reg, mem_write, mem_read, jmp, branch, invA, invB,PC2ALU, Cin, STALL, STALL2, InregWrite, OutregWrite;
   wire IF_alignErr, MEM_alignErrMem;
   wire [1:0] oper;
   wire DoneFetch, DoneMem, StallFetch, StallMem, CacheHitFetch, CacheHitMem;

   wire errCase;
   assign errCase = 1;
   always @(*) begin
      case(errCase)
        default begin err = IF_alignErr | MEM_alignErrMem; end
      endcase
    end

   hazard_detection_unit HD_unit(
   			.instr(inst),
   			.writeRegSel_DX(IX_ctrl[14:12]),
   			.writeRegSel_XM(MEM_ctrl[14:12]),
   			.writeRegSel_MWB(ctrl[14:12]),
   			.readRegSel1(inst[10:8]),
   			.readRegSel2(inst[7:5]),
   			.regWrite_DX(IX_ctrl[11]),
   			.regWrite_XM(MEM_ctrl[11]),
   			.regWrite_MWB(ctrl[11]),
   			.stall(STALL)
   			);

    assign flush = (ID_ctrl[6] | ID_ctrl[7] | IX_ctrl[6] | IX_ctrl[7] | MEM_ctrl[6] | MEM_ctrl[7] | ctrl[6] | ctrl[7]);
    assign PCtoPCreg = flush ? InPC : IF_PC2;
    assign STALL2 = STALL|StallMem;

    reg_16 REGPC(
    .en(~(STALL | StallMem | StallFetch | flush | HALTFetch | HALT) | ctrl[6] | ctrl[7]),
    .clk(clk),
    .d(PCtoPCreg),
    .rst(rst),
    .q(PC));

    cla_16b CLA0(
    .sum(IF_PC2),
    .c_out(),
    .a(PC),
    .b(16'b0000000000000010),
    .c_in(1'b0));

    assign HALT = (~(PC == 16'h0000) & (ID_inst[15:11] == 5'b00000)) | err;
    assign HALTFetch = ~(PC == 16'h0000)&(~(PCtoPCreg == 16'h0000) & (IF_inst2[15:11] == 5'b00000))|HALT;

    fetch fetch0(
    .clk(clk),
    .rst(rst),
    .inst(IF_inst),
    .In(PC),
    .alignError(IF_alignErr),
    .HALT(HALTFetch),
    .Stall(StallFetch),
    .CacheHit(CacheHitFetch),
    .Done(DoneFetch));

    assign IF_inst2 = (flush | ~DoneFetch | StallFetch) ? 16'h0800 : IF_inst;

    IF_ID IFID(
    .clk(clk),
    .rst(rst),
    .IF_inst(IF_inst2),
    .IF_PC2(IF_PC2),
    .STALL(STALL2),
    .inst(inst),
    .PC2(ID_PC2));

    assign ID_inst = (STALL | rst) ? 16'h0800 : inst;

    decode decode0(
    .inst(ID_inst),
    .writeData(regWrData),
    .clk(clk),
    .rst(rst),
    .ALUA(ID_ALUA),
    .err(),
    .OutwriteRegSel(OutwriteRegSel),
    .InwriteRegSel(InwriteRegSel),
    .ALUB(ID_ALUB),
    .toPC(ID_toPC),
    .readD2(ID_readD2),
    .mem_to_reg(mem_to_reg),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .jmp(jmp),
    .branch(branch),
    .invA(invA),
    .invB(invB),
    .PC2ALU(PC2ALU),
    .Cin(Cin),
    .oper(oper),
    .InregWrite(InregWrite),
    .OutregWrite(OutregWrite)); //Oper is funCode

    assign ID_ctrl = {HALTFetch&~STALL, OutwriteRegSel, OutregWrite, Cin, invA, invB, branch, jmp, mem_to_reg, mem_write, mem_read, PC2ALU, oper};

    ID_IX IDIX(
    .clk(clk),
    .rst(rst),
    .ID_ctrl(ID_ctrl),
    .ID_toPC(ID_toPC),
    .ID_ALUA(ID_ALUA),
    .ID_ALUB(ID_ALUB),
    .ID_inst(ID_inst),
    .ID_readD2(ID_readD2),
    .ID_PC2(ID_PC2),
    .ctrl(IX_ctrl),
    .toPC(toPC),
    .ALUA(ALUA),
    .ALUB(ALUB),
    .inst(IX_inst),
    .readD2(IX_readD2),
    .PC2(IX_PC2),
    .STALL(StallMem));

    execute execute0(
    .PC2In(IX_PC2),
    .toPC(toPC),
    .aluA(ALUA),
    .aluB(ALUB),
    .addRslt(IX_addRslt),
    .aluRslt(IX_aluRslt),
    .invA(IX_ctrl[9]),
    .invB(IX_ctrl[8]),
    .funCode(IX_ctrl[1:0]),
    .opCode(IX_inst[15:11]),
    .err(), .
    Cin(IX_ctrl[10]));

    IX_MEM IXMEM(
    .clk(clk),
    .rst(rst),
    .Stall(StallMem),
    .IX_ctrl(IX_ctrl),
    .IX_readD2(IX_readD2),
    .IX_PC2(IX_PC2),
    .IX_addRslt(IX_addRslt),
    .IX_aluRslt(IX_aluRslt),
    .ctrl(MEM_ctrl),
    .addRslt(MEM_addRslt),
    .aluRslt(MEM_aluRslt),
    .readD2(readD2),
    .PC2(MEM_PC2));

    memory memory0(
    .aluRsltIn(MEM_aluRslt),
    .memIn(readD2),
    .memOut(MEM_memOut),
    .alignErrorMem(MEM_alignErrMem),
    .clk(clk),
    .rst(rst),
    .halt(ctrl[15]),
    .ctrl(MEM_ctrl),
    .InPC(MEM_InPC),
    .PCImm(MEM_addRslt),
    .PC2(MEM_PC2),
    .Stall(StallMem),
    .CacheHit(CacheHitMem),
    .Done(DoneMem));

    MEM_WB MEMWB(
    .clk(clk),
    .rst(rst),
    .Stall(StallMem),
    .MEM_ctrl(MEM_ctrl),
    .MEM_PC2(MEM_PC2),
    .MEM_addRslt(MEM_addRslt),
    .MEM_aluRslt(MEM_aluRslt),
    .MEM_memOut(MEM_memOut),
    .MEM_InPC(MEM_InPC),
    //Output
    .ctrl(ctrl),
    .PC2(PC2),
    .addRslt(addRslt),
    .aluRslt(aluRslt),
    .memOut(memOut),
    .InPC(InPC));

    wb wb0(
    .STALL(StallMem),
    .PC2(PC2),
    .aluRslt(aluRslt),
    .InwriteRegSel(ctrl[14:12]),
    .OutwriteRegSel(InwriteRegSel),
    .PC2ALU(ctrl[2]),
    .memOut(memOut),
    .mem_to_reg(ctrl[5]),
    .regWrData(regWrData),
    .InregWrite(ctrl[11]),
    .OutregWrite(InregWrite));

endmodule // proc
`default_nettype wire
// DUMMY LINE FOR REV CONTROL :0:
