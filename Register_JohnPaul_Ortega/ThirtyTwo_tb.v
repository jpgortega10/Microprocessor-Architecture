`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Design Name:   ThirtyTwo
// Module Name:   ThirtyTwo_tb
// Project Name:  Register_JohnPaul_Ortega
////////////////////////////////////////////////////////////////////////////////
module ThirtyTwo_tb;

    // Inputs
    reg clk;
    reg RL;
    reg [4:0] DataAddress;
    reg [4:0] BusAaddress;
    reg [4:0] BusBaddress;
    reg [31:0] busD;
	 
	 
    // Outputs
    wire [31:0] busA;
    wire [31:0] busB;

    integer i;
	 
	    // Instantiate the Unit Under Test (UUT)
    ThirtyTwo uut (
        .clk(clk),
        .RL(RL),
        .DataAddress(DataAddress),
        .BusAaddress(BusAaddress),
        .BusBaddress(BusBaddress),
        .busD(busD),
        .busA(busA),
        .busB(busB)
    );
	  // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        // Initialize inputs
        RL = 0;
        DataAddress = 0;
        BusAaddress = 0;
        BusBaddress = 0;
        busD = 0;
		  
        // Let simulation settle
        #10;

        // Write unique values into all 32 registers
        for (i = 0; i < 32; i = i + 1) begin
            @(negedge clk);
            RL = 1;
            DataAddress = i;
            busD = i * 10 + 1;   // unique test value

            @(posedge clk);      // write happens here

            @(negedge clk);
            RL = 0;
        end
		          // Read all registers back through busA
        $display("Reading busA");
        for (i=0;i<32;i=i+1) begin
            BusAaddress = i;
            #1;
            $display("busA: Register[%0d] = %0d", i, busA);
        end
		  
        // Read all registers back through busB
        $display("Reading busB");
        for (i=0;i<32;i=i+1) begin
            BusBaddress = i;
            #1;
            $display("busB: Register[%0d] = %0d", i, busB);
        end
		  
        // Read two registers at the same time
        $display("Simultaneous read test");
        BusAaddress = 5;
        BusBaddress = 10;
        
        #1;
		         
        $display("busA(R5)= %0d", busA);
        $display("busB(R10)=%0d", busB);

        #20;
        $finish;
		  end
		  
endmodule
