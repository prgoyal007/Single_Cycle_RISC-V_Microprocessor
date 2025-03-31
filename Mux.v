`timescale 1ns / 1ps

module MUX21 (
    input  S,
    input [31:0] D1, D2,
    output [31:0] Y
);
    //In particular, when S is 0, the output is D1, when S is 1, the output is D2
    assign Y = S ? D2 : D1;

endmodule 