`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2026 02:35:07
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
input clk,
input reset,
input [31:0]datamem_in,
input [31:0]aluout_in,
input [3:0]r1_in,
input [3:0]r2_in,
input [3:0]rd_in,
input regwrite_in,
input mem2reg_in,

output reg [31:0]datamem_out,
output reg [31:0]aluout_out,
output reg [3:0]r1_out,
output reg[3:0]r2_out,
output reg[3:0]rd_out,
output reg regwrite_out,
output reg mem2reg_out

    );
    
    always@(posedge clk or posedge reset)
    begin
    if(reset)
    begin
    datamem_out <=0;
    aluout_out<= 0;
     r1_out <=0;
     r2_out<=0;
     rd_out<=0;
      regwrite_out<=0;
      mem2reg_out<=0;
    end
    else 
    begin
    datamem_out <= datamem_in;
    aluout_out<= aluout_in;
    r1_out <=r1_in;
    r2_out<=r2_in;
    rd_out<=rd_in;
    regwrite_out<=regwrite_in;
    mem2reg_out<=mem2reg_in;
    end
    end
endmodule
