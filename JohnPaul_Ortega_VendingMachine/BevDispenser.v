`timescale 1ns / 1ps

module BevDispenser(inBev1, inBev2, inBev3, inBev4, moneyIn, outBev1, outBev2, outBev3, outBev4, clk, rst);
	//Cost of each beverage
    parameter BEV1_COST = 25;
    parameter BEV2_COST = 20;
    parameter BEV3_COST = 75;
    parameter BEV4_COST = 100;
	 //beverage selection inputs
    //each receives 20ns pulse
    //Global reset signal (when high all outputs are 0)
    //system clock
    input inBev1, inBev2, inBev3, inBev4, rst, clk;
    
	 //Current money inserted
    input [9:0] moneyIn;
    
    //beverage dispended
    //these generate 20ns pulse
    //declared reg since assigned inside always
    output reg outBev1, outBev2, outBev3,outBev4;
	 
	  //always runs on rise edge of clock
    always @(posedge clk) begin // positive edge of clk
        if(rst == 1) begin
            //if reset, bev outputs low
            outBev1 <= 0;
            outBev2 <= 0;
            outBev3 <= 0;
            outBev4 <= 0;
				
				end else begin
                        //default behaviour
                        //ensures outputs only stay high for one clock cycle
                        outBev1 <= 0;
                        outBev2 <= 0;
                        outBev3 <= 0;
                        outBev4 <= 0;
								//checks each bev if selected and enough money
                    if(inBev1 == 1 && moneyIn >= BEV1_COST) begin
                        outBev1 <= 1;
            
                    end else if(inBev2 == 1 && moneyIn >= BEV2_COST) begin
                        outBev2 <= 1;
								end else if(inBev3 == 1 && moneyIn >= BEV3_COST) begin
                        outBev3 <= 1;
                
                    end else if(inBev4 == 1 && moneyIn >= BEV4_COST) begin
                        outBev4 <= 1;
                    end
					end
        end

endmodule
