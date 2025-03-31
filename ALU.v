`timescale 1ns / 1ps

module alu_32(
    input wire [31:0] A_in, B_in,
    input wire [3:0] ALU_Sel,
    output reg [31:0] ALU_Out,
    output reg Carry_Out, Overflow,
    output wire Zero 
);

    reg [32:0] Temp;
    
    assign Zero = (ALU_Out == 32'h00000000);
    
    always @ (*)
    begin        
        ALU_Out = 32'b0;
        Carry_Out = 1'b0;
        Overflow = 1'b0;
    
        case(ALU_Sel)
            4'b0000:    //Case 1: AND
                begin
                    ALU_Out = A_in & B_in;
                end            
            4'b0001:    //Case 2: OR
                begin
                    ALU_Out = A_in | B_in;
                end
            4'b0010:    //Case 3: ADD
                begin
                    ALU_Out = $signed(A_in) + $signed(B_in);
                    Temp = A_in + B_in;
                    Carry_Out = Temp[32];
                    Overflow = (~A_in[31] & ~B_in[31] & ALU_Out[31]) | (A_in[31] & B_in[31] & ~ALU_Out[31]);
                end
            4'b0110:    //Case 4: SUB
                begin
                    ALU_Out = $signed(A_in) - $signed(B_in);
                    Overflow = (~A_in[31] & B_in[31] & ALU_Out[31]) | (A_in[31] & ~B_in[31] & ~ALU_Out[31]);
                end
            4'b0111:    //Case 5: LESS THAN
                begin
                    ALU_Out = ($signed(A_in) < $signed(B_in)) ? 32'h00000001 : 32'h00000000;
                end
            4'b1100:    //Case 6: NOR
                begin
                    ALU_Out = ~(A_in | B_in);
                end
            4'b1111:    //Case 7: EQUAL TO
                begin
                    ALU_Out = (A_in == B_in) ? 32'h00000001 : 32'h00000000;
                end
            default:    //Default Case: ADD
                begin
                    ALU_Out = $signed(A_in) + $signed(B_in);
                    Temp = A_in + B_in;
                    Carry_Out = Temp[32];
                    Overflow = (~A_in[31] & ~B_in[31] & ALU_Out[31]) | (A_in[31] & B_in[31] & ~ALU_Out[31]);
                end
        endcase
    end
        
endmodule   //32 - bit ALU
