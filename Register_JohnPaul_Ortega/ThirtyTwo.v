`timescale 1ns / 1ps

// Name: JohnPaul Ortega
// R-Number: R11921023
//Assignment: project 2

module ThirtyTwo(
    input wire clk,
	 input wire RL, //RL: write-enable / register-load control
    
    input wire [4:0] DataAddress,//DA: 5-bit address of which register to write
    input wire [4:0] BusAaddress,//AA: 5-bit address for which register appears on bus A
    input wire [4:0] BusBaddress,//BA: 5-bit address of which register appears on bus B
    input wire [31:0] busD, //bus D: 32-bit data input for writing
    output [31:0] busA, //bus A: 32-bit output for read port A
    output [31:0] busB //bus B: 32-bit output for read port B
    );
    reg [31:0] Registers [31:0]; // 32 registers, each 32 bits wide
    
    always @(posedge clk)begin
    //initializing the 32 registers with values from the test bench
        if(RL)begin
            Registers[DataAddress] <= busD;
        end
    end
	 //assigns immediately if any value changes
    assign busA = Registers[BusAaddress];
    assign busB = Registers[BusBaddress];
    
endmodule    
	 