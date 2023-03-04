module right2 (in, shamt, oper, out);
  input [15:0]in;
  input shamt;
  input oper;
  output [15:0]out;

  assign out = shamt ? {oper ?2'b00:{2{in[15]}}, in[15:2]}:in;
endmodule
