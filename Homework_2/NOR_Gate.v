`timescale 1ns / 1ps

module NOR_Gate(A,B,X);
	input A,B;
	output X;
	
	assign X = !(A|B);


endmodule
