`timescale 1ns / 1ps

module TOP_Gate_tb;

	// Inputs
	reg A;
	reg B;
	reg C;

	// Outputs
	wire result;

	// Instantiate the Unit Under Test (UUT)
	TOP_Gate uut (
		.A(A), 
		.B(B), 
		.C(C), 
		.result(result)
	);
	
	integer i;
	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		C = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		for(i = 0;i<8;i=i+1)
			begin
				{A,B,C} = i[2:0];
				#10;
			end
		$finish;
	end
	
      
endmodule

