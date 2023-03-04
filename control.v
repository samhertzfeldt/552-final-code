module control(opCode, funCode, oper,
reg_dst, mem_to_reg, jmp, branch,
mem_read, mem_write,alu_src, LBISig, JALRSig,
reg_write, PC2ALU);
   input[4:0] opCode;
   input[1:0] funCode;

   output reg jmp, branch, JALRSig, mem_read, mem_write, reg_dst, mem_to_reg, PC2ALU;
   output reg alu_src,reg_write, LBISig;
   output reg [1:0] oper;



   always @(*) begin
    casex(opCode)
      5'b00000: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b0;
      reg_write = 1'b0;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //Halt

      5'b00001: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b0;
      reg_write = 1'b0;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //NOP

      5'b00010: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b1;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b0;
      reg_write = 1'b0;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //siic Rs

      5'b00011: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b1;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b0;
      reg_write = 1'b0;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //NOP / RTI

      5'b00100: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b1;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b1;
      reg_write = 1'b0;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //J displacement

      5'b00101: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b1;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b1;
      reg_write = 1'b0;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //JR Rs, imm

      5'b00110: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b1;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b1;
      reg_write = 1'b1;
      PC2ALU = 1'b1;
      LBISig = 1'b0;
      JALRSig = 1'b1;
      oper = 2'b00;
      end //JAL displacement

      5'b00111: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b1;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b1;
      reg_write = 1'b1;
      PC2ALU = 1'b1;
      LBISig = 1'b0;
      JALRSig = 1'b1;
      oper = 2'b00;
      end //JALR Rs, imm

      5'b01000: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b1;
      reg_write = 1'b1;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //ADDI Rd, Rs, imm

      5'b01001: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b1;
      reg_write = 1'b1;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //SUBI Rd, Rs, imm

      5'b01010: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b1;
      reg_write = 1'b1;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b11;
      end //XORI RD, Rs, imm

      5'b01011: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b1;
      reg_write = 1'b1;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b01;
      end //ANDNI Rd, Rs, imm

      5'b01100: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b1;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b0;
      reg_write = 1'b0;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //BEQZ Rs, immediate

      5'b01101: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b1;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b0;
      reg_write = 1'b0;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //BNEZ Rs, immediate

      5'b01110: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b1;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b0;
      reg_write = 1'b0;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //BLTZ Rs, immediate

      5'b01111: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b1;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b0;
      reg_write = 1'b0;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //BGEZ Rs, immediate

      5'b10000: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b1;
      alu_src = 1'b1;
      reg_write = 1'b0;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //ST Rd, Rs, immediate

      5'b10001: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b1;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b1;
      mem_write = 1'b0;
      alu_src = 1'b1;
      reg_write = 1'b1;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //LD Rd, Rs, immediate

      5'b10010: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b1;
      reg_write = 1'b1;
      PC2ALU = 1'b0;
      LBISig = 1'b1;
      JALRSig = 1'b0;
      oper = 2'b10;
      end //SLBI Rs, immediate

      5'b10011: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b1;
      alu_src = 1'b1;
      reg_write = 1'b1;
      PC2ALU = 1'b0;
      LBISig = 1'b1;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //STU Rd, Rs, immediate

      5'b10100: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b1;
      reg_write = 1'b1;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //ROLI Rd, Rs, immediate

      5'b10101: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b1;
      reg_write = 1'b1;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b01;
      end //SLLI Rd, Rs, immediate

      5'b10110: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b1;
      reg_write = 1'b1;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //RORI Rd, Rs, immediate

      5'b10111: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b1;
      reg_write = 1'b1;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b11;
      end //SRLI Rd, Rs, immediate

      5'b11000: begin
      reg_dst = 1'b0;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b1;
      reg_write = 1'b1;
      PC2ALU = 1'b0;
      LBISig = 1'b1;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //LBI Rs, immediate

      5'b11001: begin
      reg_dst = 1'b1;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b0;
      reg_write = 1'b1;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //BTR Rd, Rs

      5'b11010: begin
      reg_dst = 1'b1;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b0;
      reg_write = 1'b1;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = funCode;
      end //Barrel Ops Rd, Rs, Rt

      5'b11011: begin
      reg_dst = 1'b1;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b0;
      reg_write = 1'b1;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = funCode;
      end //ALU Ops Rd, Rs, Rt

      5'b11100: begin
      reg_dst = 1'b1;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b0;
      reg_write = 1'b1;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //SEQ Rd, Rs, Rt

      5'b11101: begin
      reg_dst = 1'b1;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b0;
      reg_write = 1'b1;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //SLT Rd, Rs, Rt

      5'b11110: begin
      reg_dst = 1'b1;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b0;
      reg_write = 1'b1;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //SLE Rd, Rs, Rt

      5'b11111: begin
      reg_dst = 1'b1;
      mem_to_reg = 1'b0;
      jmp = 1'b0;
      branch = 1'b0;
      mem_read = 1'b0;
      mem_write = 1'b0;
      alu_src = 1'b0;
      reg_write = 1'b1;
      PC2ALU = 1'b0;
      LBISig = 1'b0;
      JALRSig = 1'b0;
      oper = 2'b00;
      end //SCO Rd, Rs, Rt

   endcase

   end
endmodule
