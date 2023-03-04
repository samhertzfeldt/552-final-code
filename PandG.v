module PandG(a,b,P,G);
  input[3:0] a,b;
  output P;
  output G;

  wire[3:0] p,g;
  wire [3:0] not_g,not_p;

  nand2 nand1_1[3:0](.out(not_g), .in1(a), .in2(b));
  not1 not1_1[3:0](.out(g), .in1(not_g));
  nor2 nor2_1[3:0](.out(not_p), .in1(a), .in2(b));
  not1 not1_2[3:0](.out(p), .in1(not_p));

  assign P = &p; //P0 = p1*p2*p3*p4
  //G0 = g3 + p3*g2 + p3*g2*g1 + p3*p2*p1*g0
  assign G = g[3] | g[2]&p[3] | g[1]&p[2]&p[3] | p[3]&p[2]&p[1]&g[0];

endmodule
