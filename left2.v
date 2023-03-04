module left2(in, shamt, oper, out);
  input [15:0]in;
  input shamt;
  input oper;
  output[15:0] out;

  assign out = shamt ? {in[13:0], oper? 2'b00: in[15:14]}:in;
endmodule
