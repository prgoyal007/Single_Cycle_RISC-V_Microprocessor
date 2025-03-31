`timescale 1ns / 1ps

module processor (
    input clk, reset,
    output [31:0] Result
);

    // Internal Wires
    wire alu_src, mem2reg, reg_write, mem_read, mem_write;      //1-bit
    wire [6:0] funct7, opcode;                                  //7-bits
    wire [2:0] funct3;                                          //3-bits
    wire [3:0] operation;                                       //4-bits
    wire [1:0] alu_op;                                          //2-bits
    wire [31:0] datapath_result;                                //32-bits
    
    assign Result = datapath_result;
    
    /**** Sub Module Instantiations ****/
    // Controller
    Controller controller (
        .Opcode(opcode),                    //7-bits
        .ALUSrc(alu_src),                   //1-bit
        .MemtoReg(mem2reg),                 //1-bit
        .RegWrite(reg_write),               //1-bit
        .MemRead(mem_read),                 //1-bit
        .MemWrite(mem_write),               //1-bit
        .ALUOp(alu_op)                      //2-bits
    );
    
    // ALU Controller
    ALUController alu_controller (
        .ALUOp(alu_op),             //2-bits
        .Funct7(funct7),            //7-bits
        .Funct3(funct3),            //3-bits
        .Operation(operation)       //4-bits
    );
    
    // Processor Datapath
    data_path datapath (
        .clk(clk),                          //1-bit
        .reset(reset),                      //1-bit
        .reg_write(reg_write),              //1-bit
        .mem2reg(mem2reg),                  //1-bit
        .alu_src(alu_src),                  //1-bit
        .mem_write(mem_write),              //1-bit
        .mem_read(mem_read),                //1-bit
        .alu_cc(operation),                 //4-bits
        .opcode(opcode),                    //7-bits
        .funct7(funct7),                    //7-bits
        .funct3(funct3),                    //3-bits
        .alu_result(datapath_result)        //32-bits
    );
    
endmodule   //processor