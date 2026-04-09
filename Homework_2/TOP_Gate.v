`timescale 1ns / 1ps

module TOP_Gate(
	input A,B,C,
	output result);
	//outputs
	wire NAND_Out;
	wire NOR_Out;
	
	//specify ports
	NOR_Gate u_NOR(.A(A), .B(B),.X(NOR_Out));
	
	NAND_Gate u_NAND(.A(A),.B(B),.X(NAND_Out));
	
	AND_Gate u_AND(.A(NAND_Out),.B(C),.C(NOR_Out),.X(result));
	
	
	
	

endmodule
