module nand_cell(input wire a,
                 input wire b,
                 output wire q);
    
    wire aw;
    wire bw;
    lut_input lut_a(a, aw);
    lut_input lut_b(b,bw);
    
    lut_output lut_q(~aw | ~bw, q);
    
endmodule
