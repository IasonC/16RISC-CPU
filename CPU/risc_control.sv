module risc_control(input logic [3:0] opcode, /* opcode output from DataBus */
                    output logic [1:0] alu_op, /* ALU operation */
                    output logic jmp, beq, ram_read, write_enable, alu_src, dest_reg, mem_to_reg, reg_write, bne /* control signals */);

    always_comb begin
        case(opcode)
            4'b0000:  // LW
                begin
                    dest_reg = 1'b0;
                    alu_src = 1'b1;
                    mem_to_reg = 1'b1;
                    reg_write = 1'b1;
                    ram_read = 1'b1;
                    write_enable = 1'b0;
                    beq = 1'b0;
                    bne = 1'b0;
                    alu_op = 2'b10;
                    jmp = 1'b0;   
                end
            4'b0001:  // SW
                begin
                    dest_reg = 1'b0;
                    alu_src = 1'b1;
                    mem_to_reg = 1'b0;
                    reg_write = 1'b0;
                    ram_read = 1'b0;
                    write_enable = 1'b1;
                    beq = 1'b0;
                    bne = 1'b0;
                    alu_op = 2'b10;
                    jmp = 1'b0;   
                end
            4'b0010:  // data_processing
                begin
                    dest_reg = 1'b1;
                    alu_src = 1'b0;
                    mem_to_reg = 1'b0;
                    reg_write = 1'b1;
                    ram_read = 1'b0;
                    write_enable = 1'b0;
                    beq = 1'b0;
                    bne = 1'b0;
                    alu_op = 2'b00;
                    jmp = 1'b0;   
                end
            4'b0011:  // data_processing
                begin
                    dest_reg = 1'b1;
                    alu_src = 1'b0;
                    mem_to_reg = 1'b0;
                    reg_write = 1'b1;
                    ram_read = 1'b0;
                    write_enable = 1'b0;
                    beq = 1'b0;
                    bne = 1'b0;
                    alu_op = 2'b00;
                    jmp = 1'b0;   
                end
            4'b0100:  // data_processing
                begin
                    dest_reg = 1'b1;
                    alu_src = 1'b0;
                    mem_to_reg = 1'b0;
                    reg_write = 1'b1;
                    ram_read = 1'b0;
                    write_enable = 1'b0;
                    beq = 1'b0;
                    bne = 1'b0;
                    alu_op = 2'b00;
                    jmp = 1'b0;   
                end
            4'b0101:  // data_processing
                begin
                    dest_reg = 1'b1;
                    alu_src = 1'b0;
                    mem_to_reg = 1'b0;
                    reg_write = 1'b1;
                    ram_read = 1'b0;
                    write_enable = 1'b0;
                    beq = 1'b0;
                    bne = 1'b0;
                    alu_op = 2'b00;
                    jmp = 1'b0;   
                end
            4'b0110:  // data_processing
                begin
                    dest_reg = 1'b1;
                    alu_src = 1'b0;
                    mem_to_reg = 1'b0;
                    reg_write = 1'b1;
                    ram_read = 1'b0;
                    write_enable = 1'b0;
                    beq = 1'b0;
                    bne = 1'b0;
                    alu_op = 2'b00;
                    jmp = 1'b0;   
                end
            4'b0111:  // data_processing
                begin
                    dest_reg = 1'b1;
                    alu_src = 1'b0;
                    mem_to_reg = 1'b0;
                    reg_write = 1'b1;
                    ram_read = 1'b0;
                    write_enable = 1'b0;
                    beq = 1'b0;
                    bne = 1'b0;
                    alu_op = 2'b00;
                    jmp = 1'b0;   
                end
            4'b1000:  // data_processing
                begin
                    dest_reg = 1'b1;
                    alu_src = 1'b0;
                    mem_to_reg = 1'b0;
                    reg_write = 1'b1;
                    ram_read = 1'b0;
                    write_enable = 1'b0;
                    beq = 1'b0;
                    bne = 1'b0;
                    alu_op = 2'b00;
                    jmp = 1'b0;   
                end
            4'b1001:  // data_processing
                begin
                    dest_reg = 1'b1;
                    alu_src = 1'b0;
                    mem_to_reg = 1'b0;
                    reg_write = 1'b1;
                    ram_read = 1'b0;
                    write_enable = 1'b0;
                    beq = 1'b0;
                    bne = 1'b0;
                    alu_op = 2'b00;
                    jmp = 1'b0;   
                end
            4'b1011:  // BEQ
                begin
                    dest_reg = 1'b0;
                    alu_src = 1'b0;
                    mem_to_reg = 1'b0;
                    reg_write = 1'b0;
                    ram_read = 1'b0;
                    write_enable = 1'b0;
                    beq = 1'b1;
                    bne = 1'b0;
                    alu_op = 2'b01;
                    jmp = 1'b0;   
                end
            4'b1100:  // BNE
                begin
                    dest_reg = 1'b0;
                    alu_src = 1'b0;
                    mem_to_reg = 1'b0;
                    reg_write = 1'b0;
                    ram_read = 1'b0;
                    write_enable = 1'b0;
                    beq = 1'b0;
                    bne = 1'b1;
                    alu_op = 2'b01;
                    jmp = 1'b0;   
                end
            4'b1101:  // jmp
                begin
                    dest_reg = 1'b0;
                    alu_src = 1'b0;
                    mem_to_reg = 1'b0;
                    reg_write = 1'b0;
                    ram_read = 1'b0;
                    write_enable = 1'b0;
                    beq = 1'b0;
                    bne = 1'b0;
                    alu_op = 2'b00;
                    jmp = 1'b1;   
                end   
            default:
                begin
                    dest_reg = 1'b1;
                    alu_src = 1'b0;
                    mem_to_reg = 1'b0;
                    reg_write = 1'b1;
                    ram_read = 1'b0;
                    write_enable = 1'b0;
                    beq = 1'b0;
                    bne = 1'b0;
                    alu_op = 2'b00;
                    jmp = 1'b0; 
                end
        endcase
    end

endmodule