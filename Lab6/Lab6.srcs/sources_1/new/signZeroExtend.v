`timescale 1ns / 1ps

module signZeroExtend(
    input [15:0] immediate,
    input ExtSel,
    output [31:0] out
);
//后15位存储立即数
assign out[15:0] = immediate;
//前16位根据立即数符号进行补1或0的操作
assign out[31:16] = ExtSel ? (immediate[15] ? 16'hffff : 16'h0000) : 16'h0000;
endmodule