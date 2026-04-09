`timescale 1ns / 1ps

//Name: JohnPaul Ortega
//R-Number: R11921023

module transaction(
	 input  inBev1, inBev2, inBev3, inBev4,
    input  inNickel, inDime, inQuarter,
    input  rst, clk,

    output outBev1, outBev2, outBev3, outBev4,

    // Change outputs
    output outQuarter, outDime, outNickel,

    // Total money currently in the wallet (from CoinWallet)
    output [9:0] outCount
    );
	 // Match BevDispenser costs (keep consistent with your BevDispenser parameters)
    localparam BEV1_COST = 10'd25;
    localparam BEV2_COST = 10'd20;
    localparam BEV3_COST = 10'd75;
    localparam BEV4_COST = 10'd100;

    // Internal connection between CoinWallet and BevDispenser
    wire [9:0] moneyIn;

    // Expose money on the top-level output
    assign outCount = moneyIn;
	// Coin accumulator
	 reg walletReset_r;
    wire walletReset;
    CoinWallet wallet (
        .inQuarter(inQuarter),.inDime(inDime),.inNickel(inNickel),
		  .resetCount(walletReset),.outCount(moneyIn)
    );
	 
	 // Beverage decision/pulse generator
    BevDispenser bev (
        .inBev1(inBev1),.inBev2(inBev2),.inBev3(inBev3),.inBev4(inBev4),
        .moneyIn(moneyIn),
        .outBev1(outBev1),.outBev2(outBev2),.outBev3(outBev3),.outBev4(outBev4),
        .clk(clk),.rst(rst)
    );
	 // Detect "a beverage was dispensed"
    wire dispensePulse;
    assign dispensePulse = outBev1 | outBev2 | outBev3 | outBev4;

    // Determine which cost applies
    wire [9:0] bevCost;
    assign bevCost =
        outBev1 ? BEV1_COST :
        outBev2 ? BEV2_COST :
        outBev3 ? BEV3_COST :
        outBev4 ? BEV4_COST :
                 10'd0;
					  
					  // Compute change owed 
    wire [9:0] changeAmount;
    assign changeAmount = (moneyIn >= bevCost) ? (moneyIn - bevCost) : 10'd0;

    // Delay wallet reset by 1 clock so moneyIn stays valid long enough
    // for ChangeDispenser to latch changeAmount.

    always @(posedge clk) begin
        if (rst) walletReset_r <= 1'b0;
        else     walletReset_r <= dispensePulse;
    end
	  assign walletReset = walletReset_r;

    // Change dispenser:
    // start = dispensePulse
    // changeAmount = moneyIn - bevCost
    wire changeDone;
	 
	  ChangeDispenser change (
        .clk(clk),.rst(rst),
		  .start(dispensePulse),
        .changeAmount(changeAmount),
        .outQuarter(outQuarter),.outDime(outDime),.outNickel(outNickel),
        .done(changeDone)
    );
	 

endmodule
