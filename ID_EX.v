`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2026 01:32:19
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(
input clk,
input reset,
input stall,
input [3:0]r1_in,
input [3:0]r2_in,
input [3:0]rd_in,
input [31:0] A_in,
input [31:0] B_in,
input [31:0] pc_in,
input [31:0]imm_in,

//now control signals

input memread_in,
input memwrite_in,
input regwrite_in,
input aluop_in,
input alusrcB_in,
input mem2reg_in,


output reg [3:0]r1_out,
output reg[3:0]r2_out,
output reg[3:0]rd_out,
output reg[31:0] A_out,
output reg[31:0] B_out,
output reg[31:0] pc_out,
output reg[31:0]imm_out,
output reg memread_out,
output reg memwrite_out,
output reg regwrite_out,
output reg aluop_out,
output reg alusrcB_out,
output reg mem2reg_out
    );
    
    always@(posedge clk or posedge reset)
    begin
    if(reset)
    begin
     r1_out <=0;
     r2_out<=0;
     rd_out<=0;
      A_out<=0;
      B_out<=0;
      pc_out<=0;
     imm_out<=0;
      memread_out<=0;
      memwrite_out<=0;
      regwrite_out<=0;
      aluop_out<=0;
      alusrcB_out<=0;
      mem2reg_out<=0;
    end
    else if(!stall)
    begin
    r1_out <=r1_in;
    r2_out<=r2_in;
    rd_out<=rd_in;
    A_out<=A_in;
    B_out<=B_in;
    pc_out<=pc_in;
    imm_out<=imm_in;
    memread_out<=memread_in;
    memwrite_out<=memwrite_in;
    regwrite_out<=regwrite_in;
    aluop_out<=aluop_in;
    alusrcB_out<=alusrcB_in;
    mem2reg_out<=mem2reg_in;
    end
    
    else 
    begin
    memread_out<=0;
      memwrite_out<=0;
      regwrite_out<=0;
      aluop_out<=0;
      alusrcB_out<=0;
      mem2reg_out<=0;
    
    end
    end
endmodule
