module left4(in, shamt, oper, out);
  input [15:0]in;
  input shamt;
  input oper;
  output[15:0] out;

  assign out = shamt ? {in[11:0], oper? 4'b0000: in[15:12]}:in;
endmodule
