`include "rom.sv"
`include "pc.sv"

module instruction_memory(input logic clk, reset,
                            output logic [23:0] instr);
                            // define instruction memory I/O

    logic [7:0] pc_count; // define internal var PC counter
    
    pc pc(clk, reset, pc_count);
        // PC counter updating on rising clk edge w active-high reset

    rom rom(pc_count, instr);
        // ROM file with address being the PC counter and ROM stored
        // machine code is the 24-bit instr

endmodule