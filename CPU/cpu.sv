`include "bus.sv"
`include "risc_control.sv"

module cpu(input logic clk);

    // 16-bit RISC Harvard-Architecture CPU

    logic jmp, beq, ram_read, write_enable, alu_src, dest_reg, mem_to_reg, reg_write, bne; /* control signals */
    logic [1:0] alu_op;
    logic [3:0] opcode;

    // Data Bus
    bus bus(clk, jmp, beq, ram_read, write_enable, alu_src, dest_reg, mem_to_reg, reg_write, bne, alu_op, opcode);

    // Control Unit
    risc_control risc_control(opcode, alu_op, jmp, beq, ram_read, write_enable, alu_src, dest_reg, mem_to_reg, reg_write, bne);

endmodule