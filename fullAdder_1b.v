/*
    CS/ECE 552 FALL '22
    Homework #2, Problem 1

    a 1-bit full adder
*/
module fullAdder_1b(s, c_out, a, b, c_in);
   output s;
   output c_out;
	 input  a, b;
   input  c_in;

   wire a_xor_b,ab, abc;

	 xor2 xor1(.out(a_xor_b), .in1(a), .in2(b));
	 xor2 xor2(.out(s), .in1(a_xor_b), .in2(c_in)); //S output

	 nand2 nan1(.in1(a_xor_b), .in2(c_in), .out(abc));
	 nand2 nan2(.out(ab), .in1(a), .in2(b));
   nand2 nand3(.out(c_out), .in1(abc), .in2(ab));	

endmodule
