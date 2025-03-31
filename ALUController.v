`timescale 1ns / 1ps

module ALUController (
    input [1:0] ALUOp,
    input [6:0] Funct7,
    input [2:0] Funct3,
    output reg [3:0] Operation
);

    // Define the ALUController module behavior
    always @(*) begin
        case (ALUOp)
            2'b00: begin                                                                //I-type and Load instructions
                case (Funct3)
                    3'b000: Operation = 4'b0010;                                        //ADDI
                    3'b010: Operation = 4'b0010;                                        //LW uses ADD
                    3'b100: Operation = 4'b1100;                                        //NORI
                    3'b110: Operation = 4'b0001;                                        //ORI
                    3'b111: Operation = 4'b0000;                                        //ANDI
                    default: Operation = 4'b0000;
                endcase
            end
            
            2'b01: Operation = 4'b0010;                                                 //SW uses ADD
            
            2'b10: begin                                                                //R-type instructions
                case (Funct3)
                    3'b000: Operation = (Funct7 == 7'b0100000) ? 4'b0110 : 4'b0010;     //SUB or ADD
                    3'b010: Operation = 4'b0111;                                        //SLT
                    3'b100: Operation = 4'b1100;                                        //NOR
                    3'b110: Operation = 4'b0001;                                        //OR
                    3'b111: Operation = 4'b0000;                                        //AND
                    default: Operation = 4'b0000;
                endcase
            end
            
            default: Operation = 4'b0000;
        endcase
    end

endmodule           //ALUController

