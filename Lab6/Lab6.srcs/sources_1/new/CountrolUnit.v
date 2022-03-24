`timescale 1ns / 1ps

module controlUnit(
    input [5:0] opCode,         //操作码
    input zero,                 //运算结果标志，结果为0输出1，否则输出0
    output PCWre,               //PC是否更改（无关指令halt)
    output ALUSrcA,             //来自寄存器堆date1的的输出
    output ALUSrcB,             //来自寄存器堆date2的的输出或扩展的立即数
    output DBDataSrc,           //来自ALU运算结果的输出
    output RegWre,              //寄存器写使能
    output InsMemRW,            //读写指令存储器
    output RD,                  //读数据存储器为0，输出高阻态为1
    output WR,                  //写数据存储器为1，无操作为0
    output ExtSel,              //0扩展与符号扩展
    output RegDst,              //写寄存器地址
    output PCSrc,               //PC控制信号
    output JUMP,                //跳转信号
    output [2:0] ALUOp          //ALU8种功能
);
    
parameter ADD = 6'b000000;      //加
parameter ADDI = 6'b001000;     //加立即数
parameter SUB = 6'b000110;      //减
parameter LW = 6'b100011;       //读
parameter SW = 6'b101011;       //写
parameter BEQ = 6'b000100;      //条件跳转
parameter JMP = 6'b000010;      //跳转立即数
parameter ORI = 6'b010000;      //或立即数
parameter AND = 6'b010001;      //与
parameter OR = 6'b010010;       //或
parameter SLL = 6'b011000;      //位移
parameter HALT = 6'b111111;     //停机

//产生控制信号
assign PCWre = (opCode == HALT) ? 0 : 1;
assign ALUSrcA = (opCode == SLL) ? 1 : 0;
assign ALUSrcB = (opCode == ADDI || opCode == ORI || opCode == SW || opCode == LW) ? 1 : 0;
assign DBDataSrc = (opCode == LW) ? 1 : 0;
assign RegWre = (opCode == SW || opCode == BEQ || opCode == HALT) ? 0 : 1;
assign InsMemRW = 0;
assign RD = (opCode == LW) ? 0 : 1;
assign WR = (opCode == SW) ? 0 : 1;
assign ExtSel = (opCode == ORI) ? 0 : 1;
assign RegDst = (opCode == ADDI || opCode == ORI || opCode == LW) ? 0 : 1;
assign PCSrc = (opCode == BEQ && zero == 1) ? 1 : 0;
assign JUMP = (opCode == JMP) ? 1 : 0;
assign ALUOp[2] = (opCode == ORI || opCode == AND || opCode == ORI) ? 1 : 0;
assign ALUOp[1] = 0;
assign ALUOp[0] = (opCode == SUB || opCode == AND || opCode == BEQ) ? 1 : 0;
endmodule