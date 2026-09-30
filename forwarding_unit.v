`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.04.2026 00:09:46
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit(
input [3:0] idex_r1,
input [3:0] idex_r2,
input [3:0] exmem_rd,
input [3:0] memwb_rd,
input exmem_regwrite,
input memwb_regwrite,

output reg [1:0]f
    );
 always @(*)
 begin 
 if((exmem_regwrite==1)&&((idex_r1==exmem_rd)||(idex_r2==exmem_rd)))
     f = 1;
 else if((memwb_regwrite==1)&&((idex_r1==memwb_rd)||(idex_r2==memwb_rd)))
     f = 2;
     else begin
     f =0;
          end
end
endmodule
