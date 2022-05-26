`timescale 1ns/1ps

module race_arbiter(finished1,
                    finished2,
                    reset,
                    out,
                    done);
    input reset, finished1, finished2;
    output out;
    output done;
    
    wire cnt1_done, cnt2_done;
    assign cnt1_done = (finished1 & ~ cnt2_done);
    assign cnt2_done = (finished2 & ~ cnt1_done);
    wire winner      = cnt1_done | ~ cnt2_done;
    
    assign done = (finished1 | finished2) & ~reset;
    assign out  = winner & ~reset;
    
endmodule
