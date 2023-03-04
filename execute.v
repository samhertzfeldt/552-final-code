/*
   CS/ECE 552 Spring '22

   Filename        : execute.v
   Description     : This is the overall module for the execute stage of the processor.
*/
`default_nettype none
module execute(PC2In, toPC, aluA, Cin, aluB, addRslt, aluRslt, invA, invB, funCode, opCode, err);
   parameter OPERAND_WIDTH = 15;
   input wire /*branch, */invA, invB, Cin;
   input wire [4:0] opCode;
   input wire [1:0] funCode;
   input wire [OPERAND_WIDTH:0] PC2In, aluA, aluB, toPC;
     // TODO: Your code here
   output wire [OPERAND_WIDTH:0] addRslt, aluRslt;
   output wire  err;

   wire zero;
   wire [OPERAND_WIDTH:0] tempAdd;
   cla_16b CLA0(.sum(tempAdd), .a(PC2In), .b(toPC), .c_in(1'b0), .c_out(err));

   alu ALU0(.InA(aluA), .InB(aluB), .addRslt(addRslt), .tempAdd(tempAdd),.PC2In(PC2In), .Cin(Cin), .Oper(funCode), .OpCode(opCode),
            .invA(invA), .invB(invB), .sign(1'b1), .out(aluRslt), .Zero(zero), .Ofl());

endmodule
`default_nettype wire
