/*
    CS/ECE 552 FALL '22
    Homework #2, Problem 3

    A multi-bit ALU module (defaults to 16-bit). It is designed to choose
    the correct operation to perform on 2 multi-bit numbers from rotate
    left, shift left, shift right arithmetic, shift right logical, add,
    or, xor, & and.  Upon doing this, it should output the multi-bit result
    of the operation, as well as drive the output signals Zero and Overflow
    (OFL).
*/
module alu (InA, InB, Cin, Oper, OpCode, invA, invB, sign, out, Zero, Ofl, addRslt, tempAdd, PC2In);

    parameter OPERAND_WIDTH = 15;
    parameter NUM_OPERATIONS = 2;

    input  [OPERAND_WIDTH:0] InA, PC2In, tempAdd; // Input operand A
    input  [OPERAND_WIDTH:0] InB ; // Input operand B
    input                       Cin ; // Carry in
    input  [NUM_OPERATIONS-1:0] Oper; // Operation type
    input  [4:0] OpCode;
    input                       invA; // Signal to invert A
    input                       invB; // Signal to invert B
    input                       sign; // Signal for signed operation
    output [OPERAND_WIDTH:0] out, addRslt; // Result of computation
    output                      Ofl ; // Signal if overflow occured
    output                      Zero; // Signal if Out is 0

    /* YOUR CODE HERE */
    wire [OPERAND_WIDTH:0] inptA, inptB;
    wire[OPERAND_WIDTH:0] A;
    wire [OPERAND_WIDTH:0] B;
    wire [OPERAND_WIDTH:0] shftd;
    wire [OPERAND_WIDTH:0] sum;
    wire [OPERAND_WIDTH:0] AandB;
    wire [OPERAND_WIDTH:0] AorB;
    wire [OPERAND_WIDTH:0] AxorB;
    wire [OPERAND_WIDTH:0] outPut;
    wire [OPERAND_WIDTH:0] addOrOp, andXorOp, ALU1;
    wire barrelNot;
    wire sgndOf;
    wire Cout;
    wire [3:0] ShamtR;
    wire [OPERAND_WIDTH:0] sub;
    wire [OPERAND_WIDTH:0] inverted;
    wire [1:0] cheeseIt;

    reg [OPERAND_WIDTH:0] out, addRslt;
    assign A = invA ? ~InA : InA;
    assign B = invB ? ~InB : InB;

    cla_4b CLA4(.a(B[3:0]), .b(4'b0000), .c_in(Cin), .sum(ShamtR), .c_out());

    assign cheeseIt =((Oper == 2'b10)&(OpCode  == 5'b11010))? 2'b00 : Oper;
    shifter SFHT(.In(A), .ShAmt(ShamtR), .Oper(cheeseIt), .Out(shftd));
    cla_16b CLA(.a(A), .b(B), .c_in(Cin), .sum(sum), .c_out(Cout));

    assign sgndOf = (A[OPERAND_WIDTH]&B[OPERAND_WIDTH]&~sum[OPERAND_WIDTH]) | (~A[OPERAND_WIDTH] & ~B[OPERAND_WIDTH] & sum[OPERAND_WIDTH]);
    assign Ofl = sign ? sgndOf : Cout;

    assign inverted[OPERAND_WIDTH-15] = A[OPERAND_WIDTH];
    assign inverted[OPERAND_WIDTH-14] = A[OPERAND_WIDTH-1];
    assign inverted[OPERAND_WIDTH-13] = A[OPERAND_WIDTH-2];
    assign inverted[OPERAND_WIDTH-12] = A[OPERAND_WIDTH-3];
    assign inverted[OPERAND_WIDTH-11] = A[OPERAND_WIDTH-4];
    assign inverted[OPERAND_WIDTH-10] = A[OPERAND_WIDTH-5];
    assign inverted[OPERAND_WIDTH-9] = A[OPERAND_WIDTH-6];
    assign inverted[OPERAND_WIDTH-8] = A[OPERAND_WIDTH-7];
    assign inverted[OPERAND_WIDTH-7] = A[OPERAND_WIDTH-8];
    assign inverted[OPERAND_WIDTH-6] = A[OPERAND_WIDTH-9];
    assign inverted[OPERAND_WIDTH-5] = A[OPERAND_WIDTH-10];
    assign inverted[OPERAND_WIDTH-4] = A[OPERAND_WIDTH-11];
    assign inverted[OPERAND_WIDTH-3] = A[OPERAND_WIDTH-12];
    assign inverted[OPERAND_WIDTH-2] = A[OPERAND_WIDTH-13];
    assign inverted[OPERAND_WIDTH-1] = A[OPERAND_WIDTH-14];
    assign inverted[OPERAND_WIDTH] = A[OPERAND_WIDTH-15];
    always @(*)
    casex({OpCode, Oper})

    7'b1000???: begin//7'b10000??
      assign out = sum;
    end //ST Rd, Rs, immediate
    //LD Rd, Rs, immediate


    7'b10011??: begin
      assign out = sum;
    end //STU Rd, Rs, immediate

    7'b01000??: begin
      assign out = sum;
    end //ADDI Rd, Rs, immb

    7'b01001??: begin
      assign out = sum;
    end //SUBI Rd, Rs, imm

    7'b01010??: begin
      assign out = A ^ B;
    end //XORI RD, Rs, imm

    7'b01011??: begin
      assign out = (A&~B);
    end //ANDNI Rd, Rs, imm

    7'b101????: begin
      assign out = shftd;
    end //ROLI Rd, Rs, immediate
    //SLLI Rd, Rs, immediate
    //RORI Rd, Rs, immediate
    //SRLI Rd, Rsums, immediate


    7'b110110?: begin //7'b1101100
      assign out = sum;
    end //ALU Ops Rd, Rs, Rt

    7'b1101110: begin
      assign out = A ^ B;
    end //ALU Ops Rd, Rs, Rt

    7'b1101111: begin
      assign out = (A&~B);
    end //ALU Ops Rd, Rs, Rt


    7'b11010??: begin //7'b1101001
      assign out = shftd;
    end //Barrel Ops Rd, Rs, Rt


    7'b11100??: begin
      assign out = (A == B) ? 16'b0000000000000001 : 16'b0000000000000000;
    end //SEQ Rd, Rs, Rt

    7'b11101??: begin
      assign out = ((~sum[15]&sgndOf) | (sum[15]&~sgndOf)) ? 16'b0000000000000001 : 16'b0000000000000000;
    end //SLT Rd, Rs, Rt

    7'b11110??: begin
      assign out = (((~sum[15]&sgndOf) | (sum[15]&~sgndOf)) | (InA==InB)) ? 16'b0000000000000001 : 16'b0000000000000000;
    end //SLE Rd, Rs, Rt

    7'b11111??: begin
      assign out = Cout ? 16'b0000000000000001 : 16'b0000000000000000;
    end //SCO Rd, Rs, Rt

    7'b11001??: begin
      assign out = inverted;
    end //BTR Rd, Rs

    7'b11000??: begin
      assign out = B;
    end //LBI Rs, immediate

    7'b10010??: begin
      assign out =(A << 8) | B;
    end //LBI Rs, immediate

    7'b01100??: begin
      assign addRslt =(InA == 16'b0) ? tempAdd : PC2In;
    end //BEQZ Rs, immediate

    7'b01101??: begin
      assign addRslt =(A == 16'b0) ?  PC2In : tempAdd;
    end //BNEZ Rs, immediate

    7'b01110??: begin
      assign addRslt =(A[15] == 1'b1) ? tempAdd : PC2In;
    end //BLTZ Rs, immediate

    7'b01111??: begin
      assign addRslt = ((A == 16'b0) | (A[15] == 1'b0))? tempAdd : PC2In;
    end //BGEZ Rs, immediate

    7'b001?0??: begin //7'b00100??
      assign addRslt = tempAdd;
    end //j displacement and JAL displacement

    7'b001?1??: begin //7'b00101??
      assign addRslt = sum;
    end //JR Rs, immediate and JALR Rs, immediate

    default: begin out = 16'b0000000000000000; end
    endcase

endmodule
