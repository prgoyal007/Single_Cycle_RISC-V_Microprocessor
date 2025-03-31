`timescale 1ns / 1ps

module Controller (
    input [6:0] Opcode, 
    output reg ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite,
    output reg [1:0] ALUOp
);

    always @ (*) begin      
        case (Opcode) 
            7'b0110011: begin       //and, or, add, sub, slt, nor - (R-type)
                ALUSrc = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                ALUOp = 2'b10;
            end
            7'b0010011: begin       //andi, ori, addi, stli, nori - (I-type)
                ALUSrc = 1'b1;
                MemtoReg = 1'b0;
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                ALUOp = 2'b10;
            end
            7'b0000011: begin       //lw - (load)
                ALUSrc = 1'b1;
                MemtoReg = 1'b1;
                RegWrite = 1'b1;
                MemRead = 1'b1;
                MemWrite = 1'b0;
                ALUOp = 2'b00;
            end
            7'b0100011: begin       //sw - (store)
                ALUSrc = 1'b1;
                MemtoReg = 1'b0;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b1;
                ALUOp = 2'b01;
            end
            default: begin          //Default - No Operation
                ALUSrc = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                ALUOp = 2'b00;
            end
        endcase    
    end
endmodule   //Controller