`timescale 1ns / 1ps

module RegFile(
    input clk, reset, rg_wrt_en,
    input [4:0] rg_rd_addr1, rg_rd_addr2, rg_wrt_addr,
    input [31:0] rg_wrt_data,
    output wire [31:0] rg_rd_data1, rg_rd_data2 
    );
    
    // Internal register file: 32 registers, each 32-bits wide
    reg [31:0] register_file [31:0];
    
    // Asynchronous reset
    integer i;
    always @ (posedge reset or posedge clk) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                register_file[i] <= 32'h00000000;
            end
        end
        // Write on rising clock edge when enabled
        else if (rg_wrt_en) begin
            register_file[rg_wrt_addr] <= rg_wrt_data;
        end
    end
    
    // Combinational read logic regardless of clk or reset
    assign rg_rd_data1 = register_file[rg_rd_addr1];
    assign rg_rd_data2 = register_file[rg_rd_addr2];
    
endmodule // RegFile
