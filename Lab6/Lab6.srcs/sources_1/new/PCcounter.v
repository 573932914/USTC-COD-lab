`timescale 1ns / 1ps

module PC(clk, Reset, PCWre, JUMP,PCSrc, jimmediate, immediate, Address); 
input clk, Reset, PCWre, PCSrc,JUMP;
input [31:0] jimmediate;
input [15:0] immediate;
output [31:0] Address;
reg [31:0] Address;

always @(posedge clk or negedge Reset)
if (Reset == 0)
    Address = 0;
else
    //PCWre为1时PC更改，PCWre为0时PC不更改
    if (PCWre)
        //JUMP为1时
        if(JUMP)
            Address = jimmediate;
        //JUMP为0时
        else
            if (PCSrc)
            //跳转指令
                Address = Address + 4 + immediate * 4;
            else
            //跳转到下一指令
                Address = Address + 4;
endmodule