`timescale 100ns / 1ps
`define clk_period 10

module post_mux_counter_tb ();
    
    reg clk;
    integer count;
    
    
    // Generate Clock signal
    initial clk                    = 1'b1;
    
    wire[6:0] out_counter;
    wire finished;
    reg enable = 1;
    reg reset = 0;
   
    post_mux_counter counter (out_counter,
    finished,    // Output finished signal
    enable,      // enable for counter
    clk,         // clock Input
    reset);
    
    always #(`clk_period/2) begin
        clk    = ~clk;
        // $display(responseGet);
        // rx    <= rx_data[count];
        // count <= count + 1;
    end
endmodule
