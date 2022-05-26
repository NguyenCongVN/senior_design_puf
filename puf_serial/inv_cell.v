module inv_cell(input wire a,
                 output wire q);
    
    wire aw;
    lut_input lut_a(a,aw);
    lut_output lut_q(~aw,q);
    
endmodule