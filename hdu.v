`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2026 23:53:02
// Design Name: 
// Module Name: hdu
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


module hdu(
input [3:0]IF_IDr1,
input [3:0]IF_IDr2,
input [3:0]ID_EXrd,
input ID_EXmemread,


output stall
    );
assign stall = ((ID_EXmemread==1)&&((ID_EXrd == IF_IDr1)||(ID_EXrd == IF_IDr2)));
endmodule
