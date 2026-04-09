`timescale 1ns / 1ps

module CoinWallet(inQuarter, inDime, inNickel, outCount, resetCount);
	//Parameters define the value of each coin
    parameter QUARTER_VALUE = 25;
    parameter DIME_VALUE = 10;
    parameter NICKEL_VALUE = 5;
	 
	 //coin input pulses (20ns wide in testbench)
    //only one coin high at a time
    //resetCount = pulse that cleats all inserted money back to $0
    input inQuarter, inDime, inNickel, resetCount;
	 
	 //10-bit output representing total money inserted
    output [9:0] outCount;
	 
    //internal wire that becomes 1 when any coin or reset is high
    //event trigger for always block
    wire inMoney;
	 
	 //internal register stores
    //memory element of module
    reg [9:0] moneyCounter;
	 
	 //OR together all event sources
    assign inMoney = inQuarter | inDime | inNickel | resetCount;
	 
    //continuously drive the output with current val of moneyCounter
    //outCount is a wire copy of internal reg
    assign outCount = moneyCounter;
	 
	 //runs on the rising edge of inMoney
    //whenever a coin pulse or resetCount pulse starts
    always @(posedge inMoney) begin // You can use the above "assign" line or just use an @() to accept all inputs.
        if(resetCount == 1) begin
            //if resetCount = clear money counter
            moneyCounter <= 0;
				end else begin
            //add val of which coin is high
            moneyCounter <= moneyCounter + (inQuarter*QUARTER_VALUE + inDime*DIME_VALUE + inNickel*NICKEL_VALUE);
        end
    end
		
endmodule
