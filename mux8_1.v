module mux8_1(Sel, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, Out);
    parameter REGISTER_SIZE = 15; // register size = size-1
    parameter BINARY_SELECT = 2; // 2^3 = 8
    input [BINARY_SELECT:0] Sel;
    input [REGISTER_SIZE:0] reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8;

    output [REGISTER_SIZE:0] Out;
   // output err;

    reg [REGISTER_SIZE:0] Out;
    reg err;

    always @(*)
      begin
	casex(Sel)
         3'b000: begin Out = (reg1 === 16'bx) ? 16'b0 : reg1; end
         3'b001: begin Out = (reg2 === 16'bx) ? 16'b0 : reg2; end
         3'b010: begin Out = (reg3 === 16'bx) ? 16'b0 : reg3; end
         3'b011: begin Out = (reg4 === 16'bx) ? 16'b0 : reg4; end
         3'b100: begin Out = (reg5 === 16'bx) ? 16'b0 : reg5; end
         3'b101: begin Out = (reg6 === 16'bx) ? 16'b0 : reg6; end
         3'b110: begin Out = (reg7 === 16'bx) ? 16'b0 : reg7; end
         3'b111: begin Out = (reg8 === 16'bx) ? 16'b0 : reg8; end

	 default:
	   begin
	    err = 1'b1;
	   end
	endcase
      end

endmodule