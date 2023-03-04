module alu_control(OpCode, oper, invA, invB, Cin);
  input [4:0] OpCode;
  input [1:0] oper;
  output reg invA, invB, Cin;

always@(*)
  casex({OpCode, oper})

  7'b01001??: begin
    assign invA = 1'b1;
    assign invB = 1'b0;
    assign Cin = 1'b1;
  end //SUBI Rd, Rs, imm

  7'b10110??: begin
    assign invA = 1'b0;
    assign invB = 1'b1;
    assign Cin = 1'b1;
  end //RORI Rd, Rs, imm

  7'b1101010: begin
    assign invA = 1'b0;
    assign invB = 1'b1;
    assign Cin = 1'b1;
  end //ROR Rd, Rs, Rt

  7'b1101101: begin
    assign invA = 1'b1;
    assign invB = 1'b0;
    assign Cin = 1'b1;
  end //ALU Ops Rd, Rs, Rt

  7'b01001??: begin
    assign invA = 1'b1;
    assign invB = 1'b0;
    assign Cin = 1'b1;
  end //ALU Ops Rd, Rs, Rt


  7'b11101??: begin
    assign invA = 1'b0;
    assign invB = 1'b1;
    assign Cin = 1'b1;
  end //SLT Rd, Rs, Rt

  7'b11110??: begin
    assign invA = 1'b0;
    assign invB = 1'b1;
    assign Cin = 1'b1;
  end //SLE Rd, Rs, Rt

  default: begin
    assign invA = 1'b0;
    assign invB = 1'b0;
    assign Cin = 1'b0;
  end
  endcase
endmodule
