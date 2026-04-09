`timescale 1ns / 1ps

module transaction_tb;

	// Inputs
	reg inBev1,inBev2,inBev3,inBev4;
	reg inNickel, inDime, inQuarter;
	reg rst, clk;

	// Outputs
	wire outBev1,outBev2,outBev3,outBev4;
	wire outQuarter,outDime,outNickel;
	wire [9:0] outCount;

	transaction dut (
		.inBev1(inBev1),.inBev2(inBev2),.inBev3(inBev3),.inBev4(inBev4), 
		.inNickel(inNickel),.inDime(inDime),.inQuarter(inQuarter), 
		.rst(rst),.clk(clk), 
		.outBev1(outBev1),.outBev2(outBev2),.outBev3(outBev3),.outBev4(outBev4), 
		.outQuarter(outQuarter),.outDime(outDime),.outNickel(outNickel),.outCount(outCount)
	);
	
	 // 20ns clock (toggle every 10ns)
	  initial begin
			clk = 0;
			forever #10 clk = ~clk;
			end
			// 20ns pulse task (coin or beverage)
			task pulse20(input integer sel);
				begin
				case (sel)
					0: begin inNickel  = 1; #20 inNickel  = 0; end
					1: begin inDime    = 1; #20 inDime    = 0; end
					2: begin inQuarter = 1; #20 inQuarter = 0; end
					3: begin inBev1    = 1; #20 inBev1    = 0; end
				endcase
				#10; // small gap so CoinWallet sees separate pulses
			end
			endtask



	initial begin
		// Initialize Inputs
		inBev1 = 0;
		inBev2 = 0;
		inBev3 = 0;
		inBev4 = 0;
		inNickel = 0;
		inDime = 0;
		inQuarter = 0;
		rst = 0;
		clk = 0;
		
		// Force wallet to 0
		 #1;
		 dut.wallet.moneyCounter = 0;

		 // Release reset after a few cycles
		 repeat (3) @(posedge clk);
		 rst = 0;
		  // Insert 80 cents: 3 quarters + 1 nickel
			pulse20(2);  // quarter
			pulse20(2);  // quarter
			pulse20(2);  // quarter
			pulse20(0);  // nickel
	 
		 // Align Bev1 pulse so it's high during a posedge clk
		 @(negedge clk);
			#9 inBev1 = 1;
			#20 inBev1 = 0;
			#10;

		 // Let change pulses happen
		 repeat (10) @(posedge clk);

    $finish;
  end
  
      
endmodule

