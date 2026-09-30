`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2026 22:58:01
// Design Name: 
// Module Name: inst_mem
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


module inst_mem(
input [31:0]add,
output [31:0]inst


    );
    reg [31:0]mem [16:0];
     initial begin
        mem[0]  = 32'b0000_0001_0011_0100_0000000000000000;
        mem[4] = 32'b0100_0101_0001_0000_0000000000000000;
        mem[8] = 32'b0010_0110_0101_0000_0000000000001000;
        mem[12] = 32'b0001_0111_0110_1000_0000000000000000;
        mem[16] = 32'b1111_1001_0111_0000_0000000000001001;

     end
    assign inst = mem[add]; 
    
endmodule
