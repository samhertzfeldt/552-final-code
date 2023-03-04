/*
   CS/ECE 552 Spring '22

   Filename        : decode.v
   Description     : This is the module for the overall decode stage of the processor.
*/
`default_nettype none
module decode (inst, writeData, clk, rst, ALUA, err, Cin, oper, InregWrite, OutregWrite, InwriteRegSel, OutwriteRegSel,
		ALUB, toPC, mem_to_reg, mem_write, mem_read, jmp, branch, invA, invB, readD2, PC2ALU);

    parameter OPERAND_WIDTH = 15;
    parameter NUM_OPERATIONS = 2;
    input wire [OPERAND_WIDTH:0] inst, writeData;
    output reg [OPERAND_WIDTH:0] toPC;
    output wire [OPERAND_WIDTH:0] ALUA, ALUB, readD2;
		output wire [2:0] OutwriteRegSel;
		output wire [1:0] oper;
    input wire clk, rst, InregWrite;
		input wire [2:0] InwriteRegSel;
    output wire  mem_to_reg, jmp, branch, mem_write, mem_read, err, invA, invB, PC2ALU, Cin, OutregWrite;

	  wire alu_src;
    wire reg_dst, LBISig, JALRSig;
    wire [2:0] writeSel7_2, writeSel10_2;
    wire [OPERAND_WIDTH:0] ALUREG;
    reg [OPERAND_WIDTH:0] toALU;
   // TODO: Your code here

   control CTRL0(.opCode(inst[OPERAND_WIDTH:OPERAND_WIDTH-4]), .funCode(inst[1:0]), .oper(oper),
   .reg_dst(reg_dst), .mem_to_reg(mem_to_reg), .jmp(jmp), .branch(branch),
   .mem_read(mem_read), .mem_write(mem_write), .alu_src(alu_src),
   .reg_write(OutregWrite), .JALRSig(JALRSig), .PC2ALU(PC2ALU), .LBISig(LBISig));



    alu_control ALUCTRL(.OpCode(inst[OPERAND_WIDTH:OPERAND_WIDTH-4]), .oper(oper), .Cin(Cin), .invA(invA), .invB(invB));

    assign writeSel7_2 = reg_dst ? inst[4:2] : inst[7:5];

    assign writeSel10_2 = LBISig ? inst[10:8] : writeSel7_2;

    assign OutwriteRegSel = JALRSig ? 3'b111 : writeSel10_2;


    regFile_bypass regFile0(.read1Data(ALUA), .read2Data(ALUREG), .err(err),
       .clk(clk), .rst(rst), .read1RegSel(inst[10:8]), .read2RegSel(inst[7:5]),
       .writeRegSel(InwriteRegSel), .writeData(writeData), .writeEn(InregWrite));

	  assign readD2 = ALUREG;
    assign ALUB = alu_src ? toALU : ALUREG;

    always @(*) begin
      casex(inst[OPERAND_WIDTH:OPERAND_WIDTH-4])

          5'b0100?: begin //5'b01000
            toALU <= { {11{inst[4]}}, inst[4:0]};
          end //ADDI Rd, Rs, imm
          //SUBI Rd, Rs, imm


          5'b0101?: begin //5'b01010
            toALU <= { {11'b00000000000}, inst[4:0]};
          end //XORI RD, Rs, imm
          //ANDNI Rd, Rs, imm



          5'b011??: begin //5'b01100 *
            toPC <= { {8{inst[7]}}, inst[7:0]};
          end //BEQZ Rs, immediate
          //BNEZ Rs, immediate
          //BLTZ Rs, immediate
          //BGEZ Rs, immediate

				  5'b001?0: begin //5'b00100
				    toPC <= { {5{inst[10]}}, inst[10:0]};
				  end //J displacement
				  //JAL displacement

				  5'b001?1: begin //5'b00101
				    toALU <= { {8{inst[7]}}, inst[7:0]};
				  end //JR Rs, immediate
				  //JALR Rs, immediate

          5'b1000?: begin //5'b10000
            toALU <= { {11{inst[4]}}, inst[4:0]};
          end //ST Rd, Rs, immediate
          //LD Rd, Rs, immediate

          5'b10010: begin
            toALU <= { {8'b00000000}, inst[7:0]};
          end //SLBI Rs, immediate

          5'b10011: begin
            toALU <= { {11{inst[4]}}, inst[4:0]};
          end //STU Rd, Rs, immediate

          5'b101??: begin //5'b10100
            toALU <= { {11{inst[4]}}, inst[4:0]};
          end //ROLI Rd, Rs, immediate
          //SLLI Rd, Rs, immediate
          //RORI Rd, Rs, immediate
          //SRLI Rd, Rs, immediate

          5'b11000: begin
            toALU <= { {8{inst[7]}}, inst[7:0]};
          end //LBI Rs, immediate

       endcase

       end


endmodule
`default_nettype wire
