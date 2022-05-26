module clock_divider (input clk_i,
                      output reg clk_o);
    
    reg [22:0] count; // register from 2-> 0 (3 bits)
    
    initial begin
        clk_o = 1'b0;
        count = 0;
    end
    
    always @(posedge clk_i) begin
        if (count == 0) begin
            clk_o <= ~clk_o;
        end
        count <= count + 1;
    end
    
endmodule
