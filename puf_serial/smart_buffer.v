`timescale 1ns / 1ps

module smart_buffer(
    clock,
    dataIn,
    bit_done,
    dataOut,
    count,
    full,
    empty,
    computer_ack_reset,
    scrambler_reset,
    arbiter_reset,
    counter_reset,
    ready_to_read
    );

    input clock, dataIn, bit_done, computer_ack_reset;
    output full;
    output empty;
    output counter_reset;
    output arbiter_reset;
    output scrambler_reset;

    output reg ready_to_read;
    output [7:0] dataOut;

    output reg [3:0] count = 0;
    assign full  = (count==8)? 1'b1 : 1'b0;
    assign empty = (count==0)? 1'b1 : 1'b0;

    reg [7:0] tmp;  // the internal buffer/memory. dataOut has full access to this

    reg reset_r, reset_l, bit_done_on, bit_done_r1;
    wire reset_counter = computer_ack_reset | reset_l;
    wire reset_out = computer_ack_reset | reset_r;

    assign {arbiter_reset, scrambler_reset} = {2{reset_out}};
    assign counter_reset = reset_counter;
    assign dataOut = tmp;

    // Since "dataIn" and "bit_done" are two signals that come from the race arbiter (an asynchronous module)
    // and this module is clocked, we need to use a FIFO to make sure the buffer successfully captures these signals.

    // sync dataIn and bit_done
    reg [3:0] sync_din_r, sync_done_r;  // instantiating two FIFOs each four registers long

    // First always block to define FIFO logic. Either reset or otherwise, shift into FIFO (on MSB side) on each clock cycle.
    always @(posedge clock or posedge computer_ack_reset) begin
      if (computer_ack_reset) begin
        sync_din_r  <= 4'h0;
        sync_done_r <= 4'h0;
        bit_done_on <= 1'b0;
      end
      else begin
        sync_din_r  <= {dataIn, sync_din_r[3:1]};
        sync_done_r <= {bit_done, sync_done_r[3:1]};
	    bit_done_on <= sync_done_r[1] & ~sync_done_r[0];   // bit_done_on is negative-edge triggered
      end
    end

    // Second always block to define reset_r (local reset for scrambler and arbiter) logic. We want to make sure that reset_r
    // asserts at least two clock cycles from the time bit_done_on is asserted to ensure sufficient time to store the bit from
    // data FIFO. From there, reset_l (for the counter) is asserted one clock cycle after reset_r (three clock cycles after
    // bit_done_on)
    always @(posedge clock or posedge computer_ack_reset) begin
      if (computer_ack_reset)
        {reset_l, reset_r,bit_done_r1} <= 3'b000;
      else
        {reset_l, reset_r,bit_done_r1} <= {reset_r, bit_done_r1, bit_done_on};     // delay reset_r =  2 cycles from bit_done_on
    end

    // Third always block to define internal storage behavior.
    always @(posedge clock or posedge computer_ack_reset) begin
        if (computer_ack_reset)
            tmp <= 8'bXXXXXXXX;
        else if (bit_done_on)
            tmp <= {tmp[6:0],sync_din_r[0]};    // read in from FIFO (on LSB) side
    end

    // Fourth always block to define when the response is "ready_to_read"
    always @(posedge clock or posedge computer_ack_reset) begin
        if (computer_ack_reset) begin
            ready_to_read <= 1'b0;
            count <= 0;
        end
        else if (bit_done_on) begin
            count <= count + 1;
            if (count == 7) ready_to_read <= 1'b1;
        end
    end

endmodule
