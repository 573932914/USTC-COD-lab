`timescale 1ns / 1ps

module ALU(
    input [31:0] ReadData1, 
    input [31:0] ReadData2,
    input [31:0] inExt,
    input [5:0] insa,
    input ALUSrcA, ALUSrcB,
    input [2:0] ALUOp,
    output reg zero,
    output reg [31:0] result
);
//输入端口
wire [31:0] A;
wire [31:0] B;
//ALU输入端口的数据选择器
assign A = ALUSrcA ? insa : ReadData1;
assign B = ALUSrcB ? inExt : ReadData2;

always @(ReadData1 or ReadData2 or inExt or ALUSrcA or ALUSrcB or ALUOp or A or B)
    begin
        //根据ALUOp相应的实现运算功能 
        case(ALUOp)
            3'b000:
            begin
                result = A + B;
                zero = (result == 0)? 1 : 0;
            end
            3'b001:
            begin
                result = A - B;
                zero = (result == 0)? 1 : 0;
            end
            3'b010:
            begin
                result = (A < B) ? 1 : 0;
                zero = (result == 0)? 1 : 0;
            end
            3'b100:
            begin
                result = A | B;
                zero = (result == 0)? 1 : 0;
            end
            3'b101: 
            begin
                result = A & B;
                zero = (result == 0)? 1 : 0;
            end
            3'b011:
            begin
                result = B << A;
                zero = (result == 0)? 1 : 0;
            end
            3'b110:
            begin
                result = A ^ B;
                zero = (result == 0)? 1 : 0;
            end
            3'b111:
            begin
                result = A ^~ B;
                zero = (result == 0)? 1 : 0;
            end
        endcase
    end
endmodule