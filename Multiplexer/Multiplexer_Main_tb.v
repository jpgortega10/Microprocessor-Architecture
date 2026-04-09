`timescale 1ns / 1ps

// R-NumberR11921023: 
// Engineer:JohnPaul Ortega


module Multiplexer_Main_tb;
		reg [7:0] A,B,C,D;
		reg [1:0] sel;
		wire [7:0] X;
		integer L;
	// Instantiate the Unit Under Test (UUT)
	Multiplexer_Main uut (
		.A(A),.B(B),.C(C),.D(D),.sel(sel),.X(X)
	);

	initial begin
		// Initialize Inputs
		A = 8'd5;
		B = 8'd10;
		C = 8'd15;
		D = 8'd20;
		sel = 0;
		// Wait 100 ns for global reset to finish
		#100;
		
		// Add stimulus here
		
		for(L=0;L<4;L=L+1)
			begin
			sel = L;	
			#10;
			end
			$finish;
	end     
endmodule

