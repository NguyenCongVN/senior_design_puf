`timescale 100ns / 1ps
`define clk_period 10

module post_mux_counter_test (input CLOCK_50);
    
    reg clk;
    wire[6:0] out_counter;
    wire finished;
    reg enable = 1;
    reg reset  = 0;
    wire clk_o;
    
    clock_divider divider(CLOCK_50, clk_o);
    
    post_mux_counter counter (out_counter,
    finished,    // Output finished signal
    enable,      // enable for counter
    clk_o,         // clock Input
    reset);
endmodule
