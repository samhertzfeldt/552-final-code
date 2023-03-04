module left8(in, shamt, oper, out);
  input [15:0]in;
  input shamt;
  input oper;
  output[15:0] out;

  assign out = shamt ? {in[7:0], oper? 8'b00000000: in[15:8]}:in;
endmodule
