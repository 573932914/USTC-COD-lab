`timescale 1ns / 1ps

module SingleCycleCPU(
    input clk, rst
);
wire[5:0] opCode;
wire[31:0] Out1, Out2, curPC, Result;

wire[2:0] ALUOp;
wire[31:0] Extout, DMOut;
wire[31:0] jimmediate;
wire[15:0] immediate;
wire[4:0] rs, rt, rd;
wire[5:0] sa;
wire zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre,InsMemRW, RD, WR, ExtSel, RegDst, JUMP, PCSrc;

wire[31:0] m_out,rf_out;

ALU alu(Out1, Out2, Extout, sa, ALUSrcA, ALUSrcB, ALUOp, zero, Result);
PC pc(clk, rst, PCWre, JUMP, PCSrc, jimmediate, immediate, curPC);
controlUnit CU(opCode, zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, InsMemRW, RD, WR, ExtSel, RegDst, PCSrc, JUMP, ALUOp);
RAM datememory(
    .a(Result[9:2]),
    .d(Out2),
    .clk(clk),
    .we(~WR),
    .spo(DMOut)
);
instructionMemory im(curPC, opCode, rs, rt, rd, jimmediate, immediate, sa);
//Regfile registerfile(clk, RegWre, RegDst, opCode, rs, rt, rd, immediate, DBDataSrc, Result, DMOut, Out1, Out2);
Regfile registerfile(clk, RegWre, RegDst, opCode, rs, rt, rd, immediate[10:0], DBDataSrc, Result, DMOut, Out1, Out2, addr, rf_out);
signZeroExtend sze(immediate, ExtSel, Extout);
endmodule