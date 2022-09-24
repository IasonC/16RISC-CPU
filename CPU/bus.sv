`include "pc.sv"
`include "rom.sv"
`include "reg_file.sv"
`include "ram.sv"
`include "alu.sv"
`include "alu_control.sv"

module bus(input logic clk, jmp, beq, ram_read, write_enable, alu_src, dest_reg, mem_to_reg, reg_write, bne, /* control signals */
           input logic [1:0] alu_op, /* ALU indicator for LW, SW and BEQ, BNQ */
           output logic [3:0] opcode); /* opcode that is then passed as input to ALU for Data Processing instr's */

    logic [15:0] pc_next, pc_count, pc_branch; // PC signals
    logic [15:0] instr; // instruction fetched from ROM at address pc_count
    logic [12:0] jmp_shift; // jump shift signal
    logic [3:0] reg_write_dest; // destination register for write back - Write Address WA
    logic [15:0] reg_write_data; // data to be written back to register file at WA
    logic [3:0] reg_read_addr1, reg_read_addr2; // register read addresses
    logic [15:0] reg_read_data1, reg_read_data2; // register read data from RA1, RA2
    logic reset; // reset signal for RegFile - unsused currently
    logic [15:0] extend_immediate; // extended immediate value
    logic [2:0] alu_ctrl;
    logic [15:0] alusrc_read_data2; // data applied as ALU input from ALU SRC MUX right after RegFile
        // this is extend_immediate or the value read from RegFile RA2
    logic [15:0] alu_result; // ALU result
    logic zero; // zero flag from ALU
    logic [15:0] pc_jmp, pc_beq, pc_beq2, pc_bne, pc_bne2; // PC signals for Jump, BEQ, BNE
    logic beq_ctrl, bne_ctrl, zero_branch; // control signals for BEQ, BNE
    logic [15:0] ram_read_data; // data read in from RAM -- Data Memory

    // PC
    pc pc(.clk(clk), .pc_next(pc_next), .pc_count(pc_count), .pc_branch(pc_branch));

    // Instr Memory
    rom rom(.address(pc_count), .data_out(instr));

    // Jump
    assign jmp_shift = {instr[11:0], 1'b0};

    // MUX
    assign reg_write_dest = {1'b0, (dest_reg == 1'b1) ? instr[5:3] : instr[8:6]};

    // RegFile
    assign reg_read_addr1 = {1'b0, instr[11:9]};
    assign reg_read_addr2 = {1'b0, instr[8:6]};
    reg_file reg_file(.RA1(reg_read_addr1), .RA2(reg_read_addr2), .WA(reg_write_dest),
                      .data_in(reg_write_data), .clk(clk), .reset(reset), .write_enable(write_enable),
                      .data_out1(reg_read_data1), .data_out2(reg_read_data2));

    // immediate
    assign extend_immediate = {{10{instr[5]}},instr[5:0]};

    // ALU Control
    alu_control alu_control(.alu_op(alu_op), .opcode(instr[15:12]), .alu_ctrl(alu_ctrl));

    // alu_src MUX
    assign alusrc_read_data2 = (alu_src == 1'b1) ? extend_immediate : reg_read_data2;

    // ALU
    alu alu(.a(reg_read_data1), .b(alusrc_read_data2), .ALUControl(alu_ctrl),
            .ALUResult(alu_result), .zero(zero));

    // Branching
    assign pc_beq = pc_branch + {extend_immediate[14:0], 1'b0};
    assign pc_bne = pc_branch + {extend_immediate[14:0], 1'b0};
    assign beq_ctrl = beq & zero_branch;
    assign bne_ctrl = bne & (~zero_branch);
    assign pc_beq2 = (beq_ctrl == 1'b1) ? pc_beq : pc_branch;
    assign pc_bne2 = (bne_ctrl == 1'b1) ? pc_bne : pc_beq2;
    assign pc_jmp = {pc_branch[15:13], jmp_shift};
    
    assign pc_next = (jmp == 1'b1) ? pc_jmp : pc_bne2;

    // RAM
    ram ram(.clk(clk), .write_enable(write_enable), .ram_read(ram_read),
            .access_address(alu_result), .write_data(reg_read_data2), .data_out(ram_read_data));
    
    // write back to RAM - program values & variables
    assign reg_write_data = (mem_to_reg == 1'b1) ? ram_read_data : alu_result;

    // opcode output to ALU control unit
    assign opcode = instr[15:12];

endmodule