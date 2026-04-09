`timescale 1ns / 1ps

module NAND_Gate(A,B,X);
	input A,B;
	output X;
	
	assign X = ~(A & B);


endmodule
