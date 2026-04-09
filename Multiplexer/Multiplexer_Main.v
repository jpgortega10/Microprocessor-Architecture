`timescale 1ns / 1ps
// Name:JohnPaul Ortega
// R-Number: R11921023

module Multiplexer_Main(
	input [7:0] A,B,C,D, 
	input [1:0] sel, 
	output reg [7:0] X 
	);
	
	always @(*)begin
		case(sel)
		2'b00: X = A;
		2'b01: X = B;
		2'b10: X = C;
		2'b11: X = D;
		endcase
	end

endmodule
