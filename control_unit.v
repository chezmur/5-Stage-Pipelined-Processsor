`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2026 00:48:22
// Design Name: 
// Module Name: control_unit
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


module control_unit(
input [3:0]opcode,

output reg memread,
output reg memwrite,
output reg regwrite,
output reg aluop,
output reg alusrcB,
output reg mem2reg
    );
    
    always@(*)
    begin
    case(opcode)
    
        4'b0000: begin  //ADD
                     memread = 0;
                     memwrite = 0; 
                     regwrite =1 ;
                     aluop = 0;
                     alusrcB = 0;
                     mem2reg=0;
                     end
                     
        4'b0100: begin  //LW
                     memread = 1;
                     memwrite =0 ; 
                     regwrite =1 ;
                     aluop = 0;
                     alusrcB = 1;
                     mem2reg=1;
                     end
         
         4'b0010: begin  //LW
                     memread = 1;
                     memwrite = 0; 
                     regwrite =1 ;
                     aluop = 0;
                     alusrcB = 1;
                     mem2reg=1;
                     end
        
        4'b0001: begin //OR
                     memread = 0;
                     memwrite = 0; 
                     regwrite =1 ;
                     aluop = 1;
                     alusrcB = 0;
                     mem2reg=0;
                     end 
                     
        4'b1111: begin  //ORI
                     memread = 0;
                     memwrite = 0; 
                     regwrite =1 ;
                     aluop = 1;
                     alusrcB = 1;
                     mem2reg=0;
                     end    
                
        default: begin  //setting default values
                     memread = 0;
                     memwrite = 0; 
                     regwrite =0 ;
                     aluop = 0;
                     alusrcB = 0;
                     mem2reg=0;
                     end
    endcase
    end

endmodule
