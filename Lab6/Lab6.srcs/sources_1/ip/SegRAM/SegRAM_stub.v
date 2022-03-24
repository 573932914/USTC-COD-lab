// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Fri May 15 17:34:18 2020
// Host        : LAPTOP-J9NGC786 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/360MoveData/Users/asus/Desktop/Computer_Program/COD-labs/Lab3/Lab3/Lab3.srcs/sources_1/ip/SegRAM/SegRAM_stub.v
// Design      : SegRAM
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx485tffg1157-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_12,Vivado 2017.4" *)
module SegRAM(a, spo)
/* synthesis syn_black_box black_box_pad_pin="a[3:0],spo[15:0]" */;
  input [3:0]a;
  output [15:0]spo;
endmodule
