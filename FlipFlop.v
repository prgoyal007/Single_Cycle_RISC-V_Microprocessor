`timescale 1ns / 1ps

module FlipFlop(input clk, reset, [7:0] d, output reg [7:0] q);

    always @ (posedge clk)
        begin
            if (reset)
                q <= 8'b0000000;
            else 
                q <= d;
        end
endmodule   // FlipFlop