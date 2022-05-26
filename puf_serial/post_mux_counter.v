`timescale 1ns/1ps

module post_mux_counter (out_counter,
                         finished,    // Output finished signal
                         enable,      // enable for counter
                         clk,         // clock Input
                         reset);      // reset Input
    // `ifdef SIMONLY
    // parameter N = 6;  // For simulation use N = 6
    // `else
    // parameter N = 23;  // Otherwise use N = 23
    // `endif
    
    
    
    //----------Output Ports--------------
    output reg finished;
    output reg[6:0] out_counter;
    
    initial begin
        out_counter <= 7'b0000001;
        finished    <= 0;
    end
    //------------Input Ports--------------
    input enable, clk, reset;
    //-------------Code Starts Here-------
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out_counter <= 0;
            finished    <= 0;
            out_counter <= out_counter + 1;
        end
        else begin
            if (out_counter[6] == 1) begin
                finished <= 1'b1;
                end else begin
                if (enable && (!finished)) begin
                    out_counter <= out_counter + 1;
                end
                else out_counter <= out_counter;
            end
        end
        
        
        // if (reset) begin
        //   out      <= {N{1'b0}};
        //   finished <= 0;
        // end
        // else if (out[N-1] == 1) begin
        //     finished <= 1'b1;
        // end
        // else if (enable && (!finished)) begin
        //   out        <= out + 1;
        // end else out <= out + 1;
    end
    
endmodule
