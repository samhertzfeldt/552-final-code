/*
    CS/ECE 552 FALL'22
    Homework #2, Problem 1
    
    a 4-bit CLA module
*/
module cla_4b(sum, c_out, a, b, c_in);

    // declare constant for size of inputs, outputs (N)
    parameter   N = 4;

    output [N-1:0] sum; // 3:0
    output         c_out;
    input [N-1: 0] a, b; //3:0
    input          c_in;

    wire not_1, I_1, not_2, not_3, I_3, not_4, I_4, not_5, not_6, I_6, not_7, I_7, not_8, I_8, not_9, not_10, I_10;
    wire not_11, I_11, not_12, I_12, not_13, I_13, not_14, I_14, not_15, I_15, not_16, I_16;
    wire [N-1:0]p, g, c_i, nand_ab, nor_ab;
    


    
    //p and q
    nand2 nand2_11[N-1:0](.out(nand_ab), .in1(a), .in2(b)); // not g
    nor2 nor2_3[N-1:0](.out(nor_ab), .in1(a), .in2(b)); // not p
    not1 not1_17[N-1:0](.out(g), .in1(nand_ab)); //g
    not1 not1_18[N-1:0](.out(p), .in1(nor_ab)); //p
    
    
    //C1 = G0 + P0*c0
    fullAdder_1b fullAdder_1(.s(sum[0]), .c_out(), .a(a[0]), .b(b[0]), .c_in(c_in));// sum[0] = a+b+c_in
    nand2 nand2_1(.out(not_1), .in1(p[0]), .in2(c_in));
    not1 not1_1(.out(I_1), .in1(not_1));
    nor2 nor2_1(.out(not_2), .in1(g[0]), .in2(I_1));
    not1 not1_2(.out(c_i[0]), .in1(not_2));

    //C2 = G1 + P1*G0 + P1*P0*c0
    fullAdder_1b fullAdder_2(.s(sum[1]), .c_out(), .a(a[1]), .b(b[1]), .c_in(c_i[0])); // sum[1] = a[1] + b[1] + C1
    nand2 nand2_2(.out(not_3), .in1(p[1]), .in2(g[0]));
    not1 not1_3(.out(I_3), .in1(not_3));
    nand2 nand2_3(.out(not_4), .in1(p[1]), .in2(I_1));
    not1 not1_4(.out(I_4), .in1(not_4));
    nor3 nor3_1(.out(not_5), .in1(g[1]), .in2(I_3), .in3(I_4));
    not1 not1_5(.out(c_i[1]), .in1(not_5));

    //C3 = G2 + P2*G1 + P2*P1*G0 + P2*P1*P0*c0
    fullAdder_1b fullAdder_3(.s(sum[2]), .c_out(), .a(a[2]), .b(b[2]), .c_in(c_i[1])); //sum[2] = a[2]+b[2]+c2
    nand2 nand2_4(.out(not_16), .in1(p[2]), .in2(g[1]));//P2*G1
    not1 not1_16(.out(I_16), .in1(not_16));
    nand2 nand2_5(.out(not_6), .in1(p[2]), .in2(I_3)); //P2*(P1*G0)
    not1 not1_6(.out(I_6), .in1(not_6));
    nand2 nand2_6(.out(not_7), .in1(p[2]), .in2(I_4));// P2*(P1*P0*c0)
    not1 not1_7(.out(I_7), .in1(not_7));
    nor3 nor3_2(.out(not_8), .in1(g[2]), .in2(I_16), .in3(I_6));//G2 + (P2*G1) + (P2*P1*G0)
    not1 not1_8(.out(I_8), .in1(not_8));
    nor2 nor2_2(.out(not_9), .in1(I_8), .in2(I_7));// (G2 + P2*G1 + P2*P1*G0) + (P2*P1*P0*c0)
    not1 not1_9(.out(c_i[2]), .in1(not_9));

    //C4 = G3 + (P3*G2) + (P3*P2*G1) + (P3*P2*P1*G0) + (P3*P2*P1*P0*c0)
    fullAdder_1b fullAdder_4(.s(sum[3]), .c_out(), .a(a[3]), .b(b[3]), .c_in(c_i[2])); //sum[3] = a[3]+b[3]+c3
    nand2 nand_7(.out(not_10), .in1(p[3]), .in2(g[2])); // P3*G2
    not1 not1_10(.out(I_10), .in1(not_10));
    nand2 nand2_8(.out(not_11), .in1(p[3]), .in2(I_16)); // P3*(P2*G1)
    not1 not1_11(.out(I_11), .in1(not_11));
    nand2 nand2_9(.out(not_12), .in1(p[3]), .in2(I_6)); //P3*(P2*P1*G0)
    not1 not1_12(.out(I_12), .in1(not_12));
    nand2 nand2_10(.out(not_13), .in1(p[3]), .in2(I_7)); //P3*(P2*P1*P0*c0)
    not1 not1_13(.out(I_13), .in1(not_13));
    nor3 nor3_3(.out(not_14), .in1(g[3]), .in2(I_10), .in3(I_11)); //G3 + (P3*G2) + (P3*P2*G1)
    not1 not1_14(.out(I_14), .in1(not_14));
    nor3 nor3_4(.out(not_15), .in1(I_14), .in2(I_12), .in3(I_13)); //(G3 + (P3*G2) + (P3*P2*G1))+(P3*(P2*P1*G0))+(P3*(P2*P1*P0*c0))
    not1 not1_15(.out(c_out), .in1(not_15)); //Cout = c4

endmodule
