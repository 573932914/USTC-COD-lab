`timescale 1ns / 1ps

module instructionMemory(
    input [31:0] pc,
    output [5:0] op,
    output [4:0] rs, rt, rd,
    output [31:0] jimmediate,
    output [15:0] immediate,
    output [5:0] sa
);
wire [31:0] instruction;
//指令存储器
ROM memory(.a(pc[9:2]),.spo(instruction));
//信号分支  
assign op = instruction[31:26];
assign rs = instruction[25:21];
assign rt = instruction[20:16];
assign rd = instruction[15:11];
assign immediate = instruction[15:0];
assign sa = instruction[10:6];
assign jimmediate = {pc[31:28],instruction[25:0],2'b00};
endmodule 