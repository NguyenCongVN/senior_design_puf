`timescale 100ns / 1ps
`define clk_period 10

module top_level_serial_simple_tb ();
    
    reg clk;
    integer count;
    
    reg[3:0] KEY;
    reg[17:0] SW;
    wire[6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7;
    wire[8:0] LEDG;    // LED Green[8:0]
    wire[23:0] LEDR;   // LED Red[17:0]
    wire[35:0] GPIO_0;
    
    
    
    // Generate Clock signal
    initial count                  = 0;
    initial clk                    = 1'b1;
    // always #(`clk_period/2) clk = ~clk;
    
    // controller controllertest(clk, rx, tx);
    top_level_serial_simple controllertest(clk, KEY, SW,
    HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7,
    LEDG, LEDR, GPIO_0);
    
    always #(`clk_period/2) begin
        clk    = ~clk;
        KEY[3] = 1;
        count <= count + 1;
        if (count == 20) begin
            KEY[3] = 0;
        end
        // $display(responseGet);
        // rx    <= rx_data[count];
        // count <= count + 1;
    end
endmodule