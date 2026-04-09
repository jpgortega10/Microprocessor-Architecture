`timescale 1ns / 1ps

module AND_Gate(A,B,C,X);
	input A,B,C;
	output X;
	assign X = A & B & C;


endmodule
