`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/04/2024 07:42:15 PM
// Design Name: 
// Module Name: maddr_counter
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
///////////////////////////////////////////////////////////////////////////

module maddr_counter(
    input clk,
    input reset,
    input [1:0] cmd,          // Use 2-bit wide input for cmd
    input [10:0] load_addr,
    output [10:0] addr
);

    reg [10:0] next_addr;
    reg [10:0] addr_reg;

    always @(*) begin
        case(cmd)
            maddr.NONE:  next_addr = addr_reg;      // Maintain current address
            maddr.INC:   next_addr = addr_reg + 1;  // Increment address
            maddr.LOAD:  next_addr = load_addr;     // Load new address
            default: next_addr = 0;                 // Default case
        endcase
        
        if (reset)                      // Apply reset condition
            next_addr = 0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            addr_reg <= 0;              // Reset address register
        else
            addr_reg <= next_addr;      // Update address register
    end

    assign addr = addr_reg;             // Drive output address

endmodule
