module right4 (in, shamt, oper, out);
  input [15:0]in;
  input shamt;
  input oper;
  output [15:0]out;

  assign out = shamt ? {oper ?4'b0000:{4{in[15]}}, in[15:4]}:in;
endmodule
