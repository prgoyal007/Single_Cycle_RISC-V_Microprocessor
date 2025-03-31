# Single_Cycle_RISC-V_Microprocessor

## Overview
This project involves the design and implementation of a Single-Cycle RISC-V Microprocessor in Verilog, following a modular hardware design approach. The processor supports a subset of RISC-V instructions and includes key components such as the Datapath, Controller, ALU Controller, Register File, Memory Modules, and Multiplexers. The design was simulated and verified using Xilinx Vivado, ensuring correct instruction execution throughout waveform analysis. 

## Project Features
### Processor Development:
- Designed and implemented a Single-Cycle RISC-V processor in Verilog, ensuring correct execution of fundamental arithmetic, logical, memory, and control flow instructions.
- Developed an instruction execution pipeline using modular sub-components that interact seamlessly.

### Datapath Implementation:
Built a fully functional datapath that integrates:
- Program Counter (PC): Fetches instructions sequentially.
- Instruction Memory: Stores RISC-V machine code for execution.
- Register File: Manages read/write operations on general-purpose registers.
- Arithmetic Logic Unit (ALU): Performs computations such as addition, subtraction, AND, OR, and comparisons.
- Sign Extension Unit: Expands immediate values for correct execution of load/store instructions.
- Data Memory: Handles load (lw) and store (sw) operations.
- Multiplexers (MUXs): Route appropriate signals based on control logic.

### Control Unit Design:
Designed the Controller module to generate precise control signals based on instruction opcode.
Implemented signals including:
- ALUSrc: Determines if an operand comes from the register file or an immediate value.
- MemtoReg: Selects data memory or ALU result for register writes.
- RegWrite: Enables writing results back into registers.
- MemRead / MemWrite: Controls memory access for load and store instructions.
- ALUOp: Directs ALU behavior based on instruction type.

### ALU Controller Implementation
Developed the ALU Controller module that decodes Funct3, Funct7, and ALUOp signals to generate the correct ALU operation code (ALUCC).
Implemented logic to correctly differentiate between:
- R-type instructions (e.g., add, sub, and, or, slt).
- I-type immediate instructions (e.g., addi, andi, ori).
- Load and store instructions (lw, sw).

### Instruction Set Architecture (ISA) Compliance
Implemented a subset of the RISC-V ISA, including:
- Arithmetic operations: add, sub, addi
- Logical operations: and, or, andi, ori
- Comparison operations: slt (set less than)
- Memory operations: lw (load word), sw (store word)
- Branching: (beq, bne planned for future expansion)

### Simulation & Debugging
- Tested and validated the processor using testbenches in Xilinx Vivado.
- Used waveform analysis to debug errors in the control signals, ALU operation, and register updates.
- Verified correct instruction execution through automated test cases.

### Hardware Implementation
Ensured a synthesizable and modular design by creating separate Verilog source files for each processor component:
- Datapath.v
- Controller.v
- ALUController.v
- RegFile.v
- ALU.v
- Mux.v
- DataMem.v
- InstMem.v
- FlipFlop.v
- Processor.v (Top-level module integrating all components)
- tb_processor.v (Testbench for verification)
