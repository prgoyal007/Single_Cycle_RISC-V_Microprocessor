`timescale 1ns / 1ps
`include "DataMem.v"
`include "FlipFlop.v"
`include "ImmGen.v"
`include "Mux.v"
`include "RegFile.v"
`include "ALU.v"

module data_path #(
    parameter PC_W = 8,       // Program Counter
    parameter INS_W = 32,     // Instruction Width
    parameter RF_ADDRESS = 5, // Register File Address
    parameter DATA_W = 32,    // Data WriteData
    parameter DM_ADDRESS = 9, // Data Memory Address
    parameter ALU_CC_W = 4    // ALU Control Code Width
)(
    input                  clk ,        // CLK in datapath figure
    input                  reset,       // Reset in datapath figure      
    input                  reg_write,   // RegWrite in datapath figure
    input                  mem2reg,     // MemtoReg in datapath figure
    input                  alu_src,     // ALUSrc in datapath figure 
    input                  mem_write,   // MemWrite in datapath figure  
    input                  mem_read,    // MemRead in datapath figure          
    input  [ALU_CC_W-1:0]  alu_cc,      // ALUCC in datapath figure
    output          [6:0]  opcode,      // opcode in dataptah figure
    output          [6:0]  funct7,      // Funct7 in datapath figure
    output          [2:0]  funct3,      // Funct3 in datapath figure
    output   [DATA_W-1:0]  alu_result   // Datapath_Result in datapath figure
);

    // Internal Wires
    wire carry_out, overflow, zero;
    wire [RF_ADDRESS-1:0] rd_rg_wrt_wire, rd_rg_addr_wire1, rd_rg_addr_wire2;       //5-bits 
    wire [PC_W-1:0] pc, pc_plus4;                                                   //8-bits
    wire [INS_W-1:0] instruction;                                                   //32-bits   
    wire [DATA_W-1:0] reg1, reg2, ext_imm, src_b;                                   //32-bits
    wire [DATA_W-1:0] datamem_read, writeback_data;                                 //32-bits    

    // Extract instruction fields
    assign opcode = instruction[6:0];
    assign funct3 = instruction[14:12];
    assign funct7 = instruction[31:25];
    
    assign rd_rg_wrt_wire = instruction[11:7];
    assign rd_rg_addr_wire1 = instruction[19:15];
    assign rd_rg_addr_wire2 = instruction[24:20];
    
    // Adder (PC Update for sequential execution)
    assign pc_plus4 = pc + 4;        //8-bits
    
    /**** Sub Module Instantiations ****/
    // Program Counter (FlipFlop)
    FlipFlop PC_Reg (
        .clk(clk),          //1-bit
        .reset(reset),      //1-bit
        .d(pc_plus4),        //8-bits
        .q(pc)              //8-bits output
    );    
    // Instruction Memory
    InstMem instr_mem (
        .addr(pc),                  //8-bits
        .instruction(instruction)   //32-bits output
    );
    // Register File
    RegFile reg_file (
        .clk(clk),                              //1-bit
        .reset(reset),                          //1-bit
        .rg_wrt_en(reg_write),                  //1-bit
        .rg_rd_addr1(rd_rg_addr_wire1),         //5-bits
        .rg_rd_addr2(rd_rg_addr_wire2),         //5-bits
        .rg_wrt_addr(rd_rg_wrt_wire),           //5-bits
        .rg_wrt_data(writeback_data),           //32-bits
        .rg_rd_data1(reg1),                     //32-bits output
        .rg_rd_data2(reg2)                      //32-bits output
    );
    // Immediate Generator
    ImmGen imm_gen (
        .InstCode(instruction),         //32-bits
        .ImmOut(ext_imm)                 //32-bits output
    );
    // ALU Source MUX
    MUX21 alu_src_mux (
        .S(alu_src),                //1-bit
        .D1(reg2),                  //32-bits
        .D2(ext_imm),                //32-bits
        .Y(src_b)                    //32-bits output
    );
    // ALU
    alu_32 alu (
        .A_in(reg1),                //32-bits
        .B_in(src_b),                //32-bits
        .ALU_Sel(alu_cc),           //4-bits
        .ALU_Out(alu_result),       //32-bits output
        .Carry_Out(carry_out),      //1-bit output
        .Overflow(overflow),        //1-bit output
        .Zero(zero)                 //1-bit output
    );
    // Data Memory
    DataMem data_mem (
        .MemRead(mem_read),                 //1-bit
        .MemWrite(mem_write),               //1-bit
        .addr(alu_result[DM_ADDRESS-1:0]),             //9-bits
        .write_data(reg2),                  //32-bits
        .read_data(datamem_read)            //32-bits output
    );
    // Memory to Register MUX
    MUX21 mem2reg_mux (
        .S(mem2reg),                        //1-bit
        .D1(alu_result),                    //32-bits
        .D2(datamem_read),                  //32-bits
        .Y(writeback_data)                  //32-bits output
    );

endmodule