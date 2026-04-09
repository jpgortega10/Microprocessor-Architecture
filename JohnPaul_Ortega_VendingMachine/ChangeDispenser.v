`timescale 1ns / 1ps

module ChangeDispenser(
	 input        clk,
    input        rst,

    // Start pulse: tells the module to begin dispensing changeAmount
    input        start,
    input  [9:0] changeAmount,

    // 20ns pulses (1 clock cycle wide with 20ns period clock)
    output reg   outQuarter,
    output reg   outDime,
    output reg   outNickel,

    // High when finished returning change (stays high until next start or reset)
    output reg   done
    );
	  // Internal state: remaining change still to dispense
    reg [9:0] remaining;
    reg       active;
	 
	 always @(posedge clk) begin
        if (rst) begin
            outQuarter <= 1'b0;
            outDime    <= 1'b0;
            outNickel  <= 1'b0;
            remaining  <= 10'd0;
            active     <= 1'b0;
            done       <= 1'b0;
			end else begin
            // Default outputs low every clock -> pulses are 1 clock wide
            outQuarter <= 1'b0;
            outDime    <= 1'b0;
            outNickel  <= 1'b0;

            // Start a new change-dispense operation
            if (start) begin
                remaining <= changeAmount;
                active    <= 1'b1;
                done      <= 1'b0;
					 
					  end else if (active) begin
                // Dispense exactly ONE coin per clock (one pulse)
                if (remaining >= 10'd25) begin
                    outQuarter <= 1'b1;
                    remaining  <= remaining - 10'd25;
						  end else if (remaining >= 10'd10) begin
                    outDime   <= 1'b1;
                    remaining <= remaining - 10'd10;


                end else if (remaining >= 10'd5) begin
								outNickel <= 1'b1;
                    remaining <= remaining - 10'd5;

                end else begin
					  // remaining < 5 means no more nickels/dimes/quarters needed
                    active <= 1'b0;
                    done   <= 1'b1;
                end
            end
        end
    end

endmodule
