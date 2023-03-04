module hazard_detection_unit(writeRegSel_DX,writeRegSel_XM,writeRegSel_MWB,
readRegSel1,readRegSel2,regWrite_DX,regWrite_XM,regWrite_MWB,stall,instr);

  //Inputs
  input [15:0] instr;
  input [2:0] writeRegSel_DX, writeRegSel_XM, writeRegSel_MWB, readRegSel1, readRegSel2;
  input regWrite_DX, regWrite_XM, regWrite_MWB;
  //Outputs
  output stall;
  //Wires
  wire [1:0] numRegReads;
  //Regs
  reg r1, r2;

  num_regReads NUM_READS(.instr(instr), .regReads(numRegReads));

  assign stall = (( r1 & (readRegSel1 == writeRegSel_DX) & (regWrite_DX))
                  | (r1 & (readRegSel1 == writeRegSel_XM) & (regWrite_XM))
                  | (r2 & (readRegSel2 == writeRegSel_DX) & (regWrite_DX))
                  | (r2 & (readRegSel2 == writeRegSel_XM) & (regWrite_XM))
                 ) ? 1 : 0;

  always@(*) begin
      case(numRegReads)
        2'b00: begin
                r1 = 0;
                r2 = 0;
        end
        2'b01: begin
                r1 = 1;
                r2 = 0;
        end
        2'b10: begin
                r1 = 1;
                r2 = 1;
        end
        2'b11: begin
                r1 = 0;
                r2 = 0;
        end
        default: begin
                r1 = 0;
                r2 = 0;
        end
      endcase
  end
endmodule
