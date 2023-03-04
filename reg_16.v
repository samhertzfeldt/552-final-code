module reg_16( en,clk, d, rst, q);
  parameter REGISTER_SIZE = 15; // register size = size-1
  input clk, rst, en;
  input [REGISTER_SIZE:0] d;
  output [REGISTER_SIZE:0] q;
  wire [REGISTER_SIZE:0] temp, curr;

  assign q = curr;

  assign temp = en ? d : curr;

  dff DFF0[REGISTER_SIZE:0](.d(temp), .clk(clk), .rst(rst), .q(curr));
endmodule
