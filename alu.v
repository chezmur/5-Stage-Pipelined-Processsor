`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2026 23:49:23
// Design Name: 
// Module Name: alu
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


module alu(
input aluop,
input [31:0]a,
input [31:0]b,

output  reg [31:0]aluout
    );
    
    always@(*)
    begin
    
    case(aluop)
    
    0: aluout = a+b;
    1: aluout = a|b;
    default: aluout = 0;
    
    endcase
    
    end
endmodule
