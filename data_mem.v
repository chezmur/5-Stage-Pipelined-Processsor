`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2026 23:57:19
// Design Name: 
// Module Name: data_mem
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


module data_mem(
input clk,
input [31:0]add,
input memread,
input memwrite,
input [31:0]write_data,

output reg [31:0]data
    );
    
    reg [31:0] mem[63:0];
    initial begin
    mem[9] = 32'h2;
    mem[34] = 32'h1; //only these values matter with our instructions
    end
    
    always@(posedge clk)//synchronous
    begin
    if(memwrite)
    mem[add] = write_data;
    end
    
    always@(*)//asynchronous(instantanious)
    begin
    if(memread)
    data = mem[add];
    else
    data = 0;
    end
endmodule
