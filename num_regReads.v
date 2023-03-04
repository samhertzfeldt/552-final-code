module num_regReads(instr, regReads);

  //Inputs
  input [15:0] instr;
  //Outputs
  output [1:0] regReads;
  //Wires
  wire [4:0] opcode;
  //Regs
  reg [1:0] regReads_reg;

  assign opcode = instr[15:11];
  assign regReads = regReads_reg;

  always@(*) begin
     case(opcode)
  		5'b00000: begin			       //HALT
  					regReads_reg = 2'h0;
  				 end
  		5'b00001: begin			       //NOP
  					regReads_reg = 2'h0;
  				 end
  		5'b00100: begin			       //J
  					regReads_reg = 2'h0;
  				 end
  		5'b00110: begin			       //JAL
  					regReads_reg = 2'h0;
  				 end
  		5'b01000: begin			       //ADDI
  					regReads_reg = 2'h1;
  				 end
  		5'b01001: begin			       //SUBI
  					regReads_reg = 2'h1;
  				 end
  		5'b01010: begin			       //XORI
  					regReads_reg = 2'h1;
  				 end
  		5'b01011: begin			       //ANDNI
  					regReads_reg = 2'h1;
  				 end
  		5'b10100: begin			       //ROLI
  					regReads_reg = 2'h1;
  				 end
  		5'b10101: begin			       //SLLI
  					regReads_reg = 2'h1;
  				 end
  		5'b10110: begin			       //RORI
  					regReads_reg = 2'h1;
  				 end
  		5'b10111: begin			       //SRLI
  					regReads_reg = 2'h1;
  				 end
  		5'b10000: begin			       //ST
  					regReads_reg = 2'h2;
  				 end
  		5'b10001: begin			       //LD
  					regReads_reg = 2'h1;
  				 end
  		5'b10011: begin			       //STU
  					regReads_reg = 2'h2;
  				 end
  		5'b11000: begin			       //LBI
  					regReads_reg = 2'h0;
  				 end
  		5'b10010: begin			       //SLBI
  					regReads_reg = 2'h1;
  				 end
  		5'b00101: begin			       //JR
  					regReads_reg = 2'h1;
  				 end
  		5'b00111: begin			       //JALR
  					regReads_reg = 2'h1;
  				 end
  		5'b01100: begin			       //BEQZ
  					regReads_reg = 2'h1;
  				 end
  		5'b01101: begin			       //BNEZ
  					regReads_reg = 2'h1;
  				 end
  		5'b01110: begin			       //BLTZ
  					regReads_reg = 2'h1;
  				 end
  		5'b01111: begin			       //BGEZ
  					regReads_reg = 2'h1;
  				 end
  		5'b11001: begin			       //BTR
  					regReads_reg = 2'h1;
  				 end
  		5'b11011: begin			       //ADD, SUB, XOR, ANDN
  					regReads_reg = 2'h2;
  				 end
  		5'b11010: begin			       //ROL, SLL, ROR, SRL
  					regReads_reg = 2'h2;
  				 end
  		5'b11100: begin			       //SEQ
  					regReads_reg = 2'h2;
  				 end
  		5'b11101: begin			       //SLT
  					regReads_reg = 2'h2;
  				 end
  		5'b11110: begin			       //SLE
  					regReads_reg = 2'h2;
  				 end
  		5'b11111: begin			       //SCO
  					regReads_reg = 2'h2;
  				 end
     		default: begin
  					regReads_reg = 2'h0;
  				end
  	endcase
  end
endmodule
