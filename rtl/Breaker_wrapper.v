//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Thu Nov  7 04:07:50 2019
//Host        : DESKTOP-6E75RT8 running 64-bit major release  (build 9200)
//Command     : generate_target Breaker_wrapper.bd
//Design      : Breaker_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module Breaker_wrapper
   (Speed,
    hsync,
    left,
    main_clk,
    reset_n,
    rgb,
    right,
    vsync);
  input [1:0]Speed;
  output hsync;
  input left;
  input main_clk;
  input reset_n;
  output [2:0]rgb;
  input right;
  output vsync;

  wire [1:0]Speed;
  wire hsync;
  wire left;
  wire main_clk;
  wire reset_n;
  wire [2:0]rgb;
  wire right;
  wire vsync;

  Breaker Breaker_i
       (.Speed(Speed),
        .hsync(hsync),
        .left(left),
        .main_clk(main_clk),
        .reset_n(reset_n),
        .rgb(rgb),
        .right(right),
        .vsync(vsync));
endmodule
