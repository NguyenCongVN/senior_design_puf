`timescale 1ns/1ps

module ring_osc(enable,
                out);
    output out;
    input enable;
    wire w0;
    wire w1;
    wire w2;
    wire w3;
    wire w4;
    wire w5;
    wire w6;
    wire w7;
    wire w8;
    wire w9;
    wire w10;
    wire w11;
    wire w12;
    wire w13;
    wire w14;
    wire w15;
    
    
    // assign w15 = ~(enable & w14);
    // assign w14 = w13;             // w14 is the output we are interested in
    // assign w13 = ~ w12;
    // assign w12 = ~ w11;
    // assign w11 = ~ w10;
    // assign w10 = ~ w9;
    // assign w9  = ~ w8;
    // assign w8  = ~ w7;
    // assign w7  = ~ w6;
    // assign w6  = ~ w5;
    // assign w5  = ~ w4;
    // assign w4  = ~ w3;
    // assign w3  = ~ w2;
    // assign w2  = ~ w1;
    // assign w1  = ~ w15;
    // assign out = w14;
    inv_cell ic1(enable & w14, w15);
    assign w14 = w13;
    // lut_input lut_a(w13,w14);
    inv_cell ic14(w12, w13);
    inv_cell ic2(w11, w12);
    inv_cell ic3(w10, w11);
    inv_cell ic4(w9, w10);
    inv_cell ic5(w8, w9);
    inv_cell ic6(w7, w8);
    inv_cell ic7(w6, w7);
    inv_cell ic8(w5, w6);
    inv_cell ic9(w4, w5);
    inv_cell ic10(w3, w4);
    inv_cell ic11(w2, w3);
    inv_cell ic12(w1, w2);
    inv_cell ic15(w0, w1);
    inv_cell ic13(w15, w0);
    // lut_input lut_b(w14,out);
    
    assign out = w14;
    
endmodule
