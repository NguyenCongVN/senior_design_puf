`timescale 1ns / 1ps

module LFSR_8bit(input_challenge, output_challenge, clock, reset, increment);
  output reg [7:0] output_challenge;
  input [7:0] input_challenge;
  input clock, increment, reset;

  wire new_bit= output_challenge[1] ^ output_challenge[2] ^ output_challenge[3] ^ output_challenge[7];
  always @(posedge clock or posedge reset) begin
    if (reset) begin
        output_challenge <= input_challenge;
    end
    else
    if (increment) begin
        output_challenge <= {output_challenge[6:0], new_bit};
    end
  end

endmodule
