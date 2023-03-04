module Left1 (in, shamt, oper, out);
  input [15:0]in;
  input shamt;
  input oper;
  output [15:0] out;
  assign out = shamt ? {in[14:0], oper ? 1'b0: in[15]}:in;
endmodule
