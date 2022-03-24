`timescale 1ns / 1ps

module Regfile(clk, RegWre, RegDst, opCode, rs, rt, rd, im, DBDataSrc, dataFromALU, dataFromRW, Data1, Data2, read_addr, read_out);
input clk, RegDst, RegWre, DBDataSrc;
input [5:0] opCode;
input [4:0] rs, rt, rd;
input [10:0] im;
input [31:0] dataFromALU, dataFromRW;
output [31:0] Data1, Data2;

input [7:0] read_addr;
output [31:0] read_out;

//要写的寄存器端口
wire [4:0] writeReg;
//要写的数据
wire [31:0] writeData;
//RegDst为真时，处理R型指令，rd为目标操作数寄存器，为假时处理I型指令
assign writeReg = RegDst ? rd : rt;
//ALUM2Reg为0时，使用来自ALU的输出，为1时，使用来自数据存储器的输出
assign writeData = DBDataSrc ? dataFromRW : dataFromALU;

//初始化寄存器
reg [31:0] register[0:31];
integer i;
initial for (i = 0; i < 32; i = i + 1) register[i] <= 0;

// Data1 为ALU运算时的A，当指令为sll时，A的值从立即数的16位中获得
// Data2 位ALU运算中的B，其值始终是为rt
assign Data1 = (opCode == 6'b011000) ? im[10:6] : register[rs];
assign Data2 = register[rt];
always @(RegDst or RegWre or DBDataSrc or writeReg or writeData)
if(RegWre && writeReg)
    register[writeReg] = writeData;//防止数据写入0号寄存器

assign read_out = register[read_addr[4:0]];
endmodule