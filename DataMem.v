`timescale 1ns / 1ps

module DataMem(
    input MemRead, MemWrite, 
    input [8:0] addr, 
    input [31:0] write_data, 
    output reg [31:0] read_data
);
    
    reg [31:0] memory [127:0];
    
    integer i;
    initial begin
        for (i = 0; i < 128; i = i + 1) begin
            memory[i] = 32'b0;
        end     
    end
    
    always @ (*) begin
        if (MemRead) begin
            read_data = memory[addr[8:2]];   
        end 
        else begin
            read_data = 32'b0;
        end
        
        if (MemWrite) begin
            memory[addr[8:2]] = write_data;
        end  
    end
    
endmodule
