`timescale 1ns / 1ps

module top(
    input clk,
    input reset
);

// Instruction Fetch

wire [31:0] pc_current;
wire [31:0] pc_plus4;
wire [31:0] instruction;
wire stall;

pc PC(
    .clk(clk),
    .reset(reset),
    .next_pc(pc_plus4),
    .stall(stall),
    .address(pc_current)
);

pc_adder ADDER(
    .pc_in(pc_current),
    .pc_out(pc_plus4)
);

inst_mem IMEM(
    .add(pc_current),
    .inst(instruction)
);


//IF/ID reg

wire [31:0] ifid_inst;
wire [31:0] ifid_pc;

IF_ID IFID(
    .clk(clk),
    .reset(reset),
    .stall(stall),
    .inst_in(instruction),
    .nextpc_in(pc_plus4),
    .inst_out(ifid_inst),
    .nextpc_out(ifid_pc)
);


//Ibstruction Decode

wire [3:0] opcode;
wire [3:0] r1, r2, rd;
wire [15:0] imm;

assign opcode = ifid_inst[31:28];
assign rd     = ifid_inst[27:24];
assign r1     = ifid_inst[23:20];
assign r2   = ifid_inst[19:16];
assign imm    = ifid_inst[15:0];

wire memread;
wire memwrite;
wire regwrite;
wire aluop;
wire alusrcB;
wire mem2reg;

control_unit CU(
    .opcode(opcode),
    .memread(memread),
    .memwrite(memwrite),
    .regwrite(regwrite),
    .aluop(aluop),
    .alusrcB(alusrcB),
    .mem2reg(mem2reg)
);


//Register File

wire [31:0] regA;
wire [31:0] regB;
wire [31:0] write_back;
wire [3:0] memwb_rd;
wire memwb_regwrite;

reg_file RF(
    .clk(clk),
    .r1(r1),
    .r2(r2),
    .rd(memwb_rd),
    .reg_write(memwb_regwrite),
    .write_data(write_back),
    .rd1(regA),
    .rd2(regB)
);


//Sign Extend

wire [31:0] imm_ext;

sign_extend SE(
    .imm_in(imm),
    .imm_out(imm_ext)
);


//Hazard Detection Unit (Stalling logic)

wire [3:0] idex_rd;
wire idex_memread;

hdu HDU(
    .IF_IDr1(r1),
    .IF_IDr2(r2),
    .ID_EXrd(idex_rd),
    .ID_EXmemread(idex_memread),
    .stall(stall)
);


//ID/EX reg

wire [3:0] idex_r1, idex_r2;
wire [31:0] idex_A, idex_B;
wire [31:0] idex_pc, idex_imm;

wire idex_memwrite;
wire idex_regwrite;
wire idex_aluop;
wire idex_alusrcB;
wire idex_mem2reg;

ID_EX IDEX(
    .clk(clk),
    .reset(reset),
    .stall(stall),

    .r1_in(r1),
    .r2_in(r2),
    .rd_in(rd),

    .A_in(regA),
    .B_in(regB),
    .pc_in(ifid_pc),
    .imm_in(imm_ext),

    .memread_in(memread),
    .memwrite_in(memwrite),
    .regwrite_in(regwrite),
    .aluop_in(aluop),
    .alusrcB_in(alusrcB),
    .mem2reg_in(mem2reg),

    .r1_out(idex_r1),
    .r2_out(idex_r2),
    .rd_out(idex_rd),

    .A_out(idex_A),
    .B_out(idex_B),
    .pc_out(idex_pc),
    .imm_out(idex_imm),

    .memread_out(idex_memread),
    .memwrite_out(idex_memwrite),
    .regwrite_out(idex_regwrite),
    .aluop_out(idex_aluop),
    .alusrcB_out(idex_alusrcB),
    .mem2reg_out(idex_mem2reg)
);


//Forwarding logic

wire [3:0] exmem_rd;
wire [3:0] memwb_rd_f;
wire exmem_regwrite;
wire memwb_regwrite_f;

wire [1:0]fs;

forwarding_unit FU(
    .idex_r1(idex_r1),
    .idex_r2(idex_r2),
    .exmem_rd(exmem_rd),
    .memwb_rd(memwb_rd_f),
    .exmem_regwrite(exmem_regwrite),
    .memwb_regwrite(memwb_regwrite_f),
    .f(fs)
);


//Fowarding MUX

wire [31:0] exmem_alu;
wire [31:0] memwb_alu;
wire [31:0] memwb_data;

wire [31:0] forwardA;
wire [31:0] forwardB;

assign forwardA = (fs[0])  ? exmem_alu :
                  (fs[1]) ? write_back :
                            idex_A;

assign forwardB =  idex_B;


//Execute

wire [31:0] alu_in2;
wire [31:0] alu_out;

assign alu_in2 = (idex_alusrcB) ? idex_imm : forwardB;

alu ALU(
    .aluop(idex_aluop),
    .a(forwardA),
    .b(alu_in2),
    .aluout(alu_out)
);


//EX/MEM reg

wire exmem_memread;
wire exmem_memwrite;
wire exmem_mem2reg;
wire [3:0]exmem_r1;
wire [3:0]exmem_r2;
EX_MEM EXMEM(
    .clk(clk),
    .reset(reset),

    .aluout_in(alu_out),
    .r1_in(idex_r1),
    .r2_in(idex_r2),
    .rd_in(idex_rd),
    .pc_in(idex_pc),

    .memread_in(idex_memread),
    .memwrite_in(idex_memwrite),
    .regwrite_in(idex_regwrite),
    .mem2reg_in(idex_mem2reg),

    .aluout_out(exmem_alu),
    .r1_out(exmem_r1),
    .r2_out(exmem_r2),
    .rd_out(exmem_rd),
    .memread_out(exmem_memread),
    .memwrite_out(exmem_memwrite),
    .regwrite_out(exmem_regwrite),
    .mem2reg_out(exmem_mem2reg)
);


//Data memory

wire [31:0] mem_data;
wire [3:0] memwb_r1;
wire [3:0] memwb_r2;
data_mem DM(
    .clk(clk),
    .add(exmem_alu),
    .memread(exmem_memread),
    .memwrite(exmem_memwrite),
    .write_data(forwardB),
    .data(mem_data)
);


//MEM/WB reg

MEM_WB MEMWB(
    .clk(clk),
    .reset(reset),

    .datamem_in(mem_data),
    .aluout_in(exmem_alu),
    .r1_in(exmem_r1),
    .r2_in(exmem_r2),
    .rd_in(exmem_rd),
    .regwrite_in(exmem_regwrite),
    .mem2reg_in(exmem_mem2reg),

    .datamem_out(memwb_data),
    .aluout_out(memwb_alu),
    .r1_out(memwb_r1),
    .r2_out(memwb_r2),
    .rd_out(memwb_rd),
    .regwrite_out(memwb_regwrite),
    .mem2reg_out(memwb_mem2reg)
);


//Write back 

wire memwb_mem2reg;

assign write_back = (memwb_mem2reg) ? memwb_data : memwb_alu;

assign memwb_rd_f = memwb_rd;
assign memwb_regwrite_f = memwb_regwrite;

endmodule