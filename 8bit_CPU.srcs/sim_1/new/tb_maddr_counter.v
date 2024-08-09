`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/04/2024 08:14:51 PM
// Design Name: 
// Module Name: tb_maddr_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_maddr_counter();
    reg clk;
    reg reset;
    reg [1:0] cmd;
    reg [10:0] load_addr;
    wire [10:0] addr;

    // Instantiate the parameter module to access the parameters
    maddr maddr_inst();

    maddr_counter uut(
        .clk(clk),
        .reset(reset),
        .cmd(cmd),
        .load_addr(load_addr),
        .addr(addr)
    );

    // Clock generation
    always begin 
        #5 clk = ~clk; 
    end
    
    initial begin
        clk = 0;
        reset = 0;
        cmd = maddr_inst.NONE;
        load_addr = 11'b1;
        #10;
        cmd = maddr_inst.LOAD;
        #10;
        reset = 1;
        #10;
        reset = 0;
        cmd = maddr_inst.INC;       
        #20;
        $finish;
    end
endmodule
