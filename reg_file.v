`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2026 23:24:07
// Design Name: 
// Module Name: reg_file
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


module reg_file(
input clk,
input [3:0]r1,
input [3:0]r2,
input [3:0]rd,
input reg_write,
input [31:0]write_data,
output [31:0]rd1,
output [31:0]rd2 

    );
    
    reg [31:0]rf [9:0];
    
    initial begin
    rf[0] =0;
    rf[1]=0;
    rf[2] =0;
    rf[3]=32'h18;
    rf[4] =32'hA;
    rf[5]=0;
    rf[6] =0;
    rf[7]=0;
    rf[8] =32'hCF001;
    rf[9]= 0;
    end
    
    assign rd1 = rf[r1];
    assign rd2 = rf[r2];
    
    always@(posedge clk)
    begin
    if(reg_write)
    rf[rd]<=write_data;
    end
    
endmodule
