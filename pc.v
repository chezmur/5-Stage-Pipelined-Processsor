`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2026 22:50:40
// Design Name: 
// Module Name: pc
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


module pc(
input clk,
input reset,
input [31:0]next_pc,

input stall,
output reg [31:0]address

    );
    always@(posedge clk or posedge reset)
    begin
    if(reset)
    address <= 32'b0;
    else if(!stall)
    address <= next_pc;
    
    
    
    end
endmodule
