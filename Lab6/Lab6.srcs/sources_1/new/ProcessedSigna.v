`timescale 1ns / 1ps

module ProcessedSignal
#(parameter CountTime = 5)
(
    input oldsign,
    input clk,
    output reg newsign
);
reg [31:0] Count;

always @(posedge clk or oldsign)
begin
    if(oldsign == 0)
    begin
        newsign <= 0;
        Count <= 0;
    end
    else
    begin
        if(Count <= CountTime)
            Count <= Count+1;
        else
            newsign <= 1;
    end
end
endmodule