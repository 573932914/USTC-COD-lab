`timescale 1ns / 1ps

module SingleCircleCPUTest;
reg CLK;
reg Reset;

SingleCycleCPU uut (CLK, Reset);

initial
begin
    CLK = 0;
    Reset = 0;
    #50;
    CLK = 1;
    #50;
    Reset = 1;
    forever #5
    begin
        CLK = !CLK;
    end
end
endmodule