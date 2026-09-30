`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2026 00:13:56
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
input clk,
input reset,
input stall,
input [31:0]inst_in,
input [31:0]nextpc_in,

output reg [31:0]inst_out,
output reg [31:0]nextpc_out
    );
    
    always@(posedge clk or posedge reset)
    begin
    
    if(reset)
    begin
    inst_out  <= 0;
    nextpc_out <= 0;
    end
    
    else if(!stall)
    begin
    inst_out <= inst_in;
    nextpc_out <= nextpc_in;
    end
    
    end
endmodule
