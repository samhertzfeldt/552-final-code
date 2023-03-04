/*
    CS/ECE 552 FALL '22
    Homework #2, Problem 2
    
    A barrel shifter module.  It is designed to shift a number via rotate
    left, shift left, shift right arithmetic, or shift right logical based
    on the 'Oper' value that is passed in.  It uses these
    shifts to shift the value any number of bits.
 */
module shifter (In, ShAmt, Oper, Out);

    // declare constant for size of inputs, outputs, and # bits to shift
    parameter OPERAND_WIDTH = 16;
    parameter SHAMT_WIDTH   =  4;
    parameter NUM_OPERATIONS = 2;

    input  [OPERAND_WIDTH -1:0] In   ; // Input operand
    input  [SHAMT_WIDTH   -1:0] ShAmt; // Amount to shift/rotate
    input  [NUM_OPERATIONS-1:0] Oper ; // Operation type
    output [OPERAND_WIDTH -1:0] Out  ; // Result of shift/rotate

   /* YOUR CODE HERE */
    wire[15:0] L_1, L_2, L_4, L_8;
    wire[15:0] R_1, R_2, R_4, R_8;

    Left1 Left1_1(.in(In), .shamt(ShAmt[0]), .oper(Oper[0]), .out(L_1));
    left2 left2_1(.in(L_1), .shamt(ShAmt[1]), .oper(Oper[0]), .out(L_2));
    left4 left4_1(.in(L_2), .shamt(ShAmt[2]), .oper(Oper[0]), .out(L_4));
    left8 left8_1(.in(L_4), .shamt(ShAmt[3]), .oper(Oper[0]), .out(L_8));

    right1 Right1_1(.in(In), .shamt(ShAmt[0]), .oper(Oper[0]), .out(R_1));
    right2 Right2_1(.in(R_1), .shamt(ShAmt[1]), .oper(Oper[0]), .out(R_2));
    right4 Right4_1(.in(R_2), .shamt(ShAmt[2]), .oper(Oper[0]), .out(R_4));
    right8 Right8_1(.in(R_4), .shamt(ShAmt[3]), .oper(Oper[0]), .out(R_8));


    assign Out = Oper[1]? R_8 : L_8;
   
endmodule
