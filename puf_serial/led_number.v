module led7(input CLOCK_50,
            input [3:0] KEY,
            input [17:0] SW,
            output [6:0] HEX0,
            HEX1,
            HEX2,
            HEX3,
            HEX4,
            HEX5,
            HEX6,
            HEX7,
            output [8:0] LEDG,    // LED Green[8:0]
            output [23:0] LEDR,   // LED Red[17:0]
            inout [35:0] GPIO_0);
    reg [2:0] A0;
    reg [2:0] A1;
    reg [2:0] A2;
    reg [2:0] A3;
    reg [2:0] A4;
    reg [2:0] A5;
    reg [2:0] A6;
    reg [2:0] A7;
    // set all inout ports to tri-state
    assign GPIO_0 = 36'hzzzzzzzzz;
    // Connect dip switches to red LEDs
    assign LEDR[2:0]   = A0;
    assign LEDR[5:3]   = A1;
    assign LEDR[8:6]   = A2;
    assign LEDR[11:9]  = A3;
    assign LEDR[14:12] = A4;
    assign LEDR[17:15] = A5;
    assign LEDR[20:18] = A6;
    assign LEDR[23:21] = A7;
    // turn off green LEDs
    assign LEDG[8:0] = 0;
    
    wire clk_o;
    clock_divider divider(CLOCK_50, clk_o);
    
    // map to 7-segment displays
    hex_7seg dsp0(A0,HEX0);
    hex_7seg dsp1(A1,HEX1);
    hex_7seg dsp2(A2,HEX2);
    hex_7seg dsp3(A3,HEX3);
    hex_7seg dsp4(A4,HEX4);
    hex_7seg dsp5(A5,HEX5);
    hex_7seg dsp6(A6,HEX6);
    hex_7seg dsp7(A7,HEX7);
    // control (set) value of A, signal with KEY3
    initial begin
        A0 = 3'b000;
        A1 = 3'b000;
        A2 = 3'b000;
        A3 = 3'b000;
        A4 = 3'b000;
        A5 = 3'b000;
        A6 = 3'b000;
        A7 = 3'b000;
    end
    
    always @(negedge KEY[3]) begin
    // always @(posedge clk_o) begin
        A0 <= A0 + 1;
        A1 <= A1 + 1;
        A2 <= A2 + 1;
        A3 <= A3 + 1;
        A4 <= A4 + 1;
        A5 <= A5 + 1;
        A6 <= A6 + 1;
        A7 <= A7 + 1;
    end
endmodule
