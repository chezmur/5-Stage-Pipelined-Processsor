`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2026 01:55:12
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM(
input clk, reset,
input [31:0]aluout_in,
input [3:0]r1_in,
input [3:0]r2_in,
input [3:0]rd_in,
input [31:0] pc_in,
input memread_in,
input memwrite_in,
input regwrite_in,
input mem2reg_in,

output reg [31:0]aluout_out,
output reg [3:0]r1_out,
output reg[3:0]r2_out,
output reg[3:0]rd_out,
output reg[31:0] pc_out,
output reg memread_out,
output reg memwrite_out,
output reg regwrite_out,
output reg mem2reg_out

    );
    
    always@(posedge clk or posedge reset)
    begin
    if(reset)
    begin
    aluout_out<= 0;
     r1_out <=0;
     r2_out<=0;
     rd_out<=0;
      pc_out<=0;
   
      memread_out<=0;
      memwrite_out<=0;
      regwrite_out<=0;
    
   
      mem2reg_out<=0;
    end
    else 
    begin
    aluout_out<= aluout_in;
    r1_out <=r1_in;
    r2_out<=r2_in;
    rd_out<=rd_in;
    
    
    pc_out<=pc_in;
    
    memread_out<=memread_in;
    memwrite_out<=memwrite_in;
    regwrite_out<=regwrite_in;
    
    mem2reg_out<=mem2reg_in;
    end
    end
endmodule
