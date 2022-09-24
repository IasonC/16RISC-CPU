`timescale 1ns/1ps // define timescale 1 ns and resolution 1 ps = 0.001 ns

`include "risc_control.sv" // include DUT = device under test

module risc_control_tb; // testbench for testing the risc_control.sv ROM module - testbench has no I/O

    // define internal vars used in the testbench
    logic [3:0] opcode;
    logic [1:0] alu_op;
    logic jmp, beq, ram_read, write_enable, alu_src, dest_reg, mem_to_reg, reg_write, bne;

    logic condition1, condition2, condition3; // for self-checking testbench readability -- break up long conditional
    logic [5:0] tests_passed = 5'b0; // counter for tests successfully passed

    risc_control dut (opcode, alu_op, jmp, beq, ram_read, write_enable, alu_src, dest_reg, mem_to_reg, reg_write, bne);
    // define the risc_control.sv as DUT w its I/O

    // Self-checking testbench:
    initial // single-pass code block initialisation
    begin
        $dumpfile("risc_control_tb.vcd"); /* dump var changes of the testbench file 
                                  onto this Variable Dump Changes (vcd) file */
        $dumpvars(0, risc_control_tb);   /* Specifies to dump into VCD the lvl 0 file (i.e. top-level file) 
                                  w module name risc_control_tb */

        #10; // opcode = 4'bx now so the default case is active
        condition1 = dest_reg == 1'b1 & alu_src == 1'b0 & mem_to_reg == 1'b0 & reg_write == 1'b1;
        condition2 = ram_read == 1'b0 & write_enable == 1'b0 & beq == 1'b0 & bne == 1'b0;
        condition3 = alu_op == 2'b00 & jmp == 1'b0;
        if (condition1 & condition2 & condition3) $display("opcode X PASS");
        if (condition1 & condition2 & condition3) tests_passed = tests_passed + 5'b1;
 
        #10; opcode = 4'b0000; // opcode = 0
        // still default case active as opcode was just updated
        if (condition1 & condition2 & condition3) $display("opcode X PASS (2nd time)");
        if (condition1 & condition2 & condition3) tests_passed = tests_passed + 5'b1;

        #1; // opcode updated and case statement executed for opcode = 0
        condition1 = dest_reg == 1'b0 & alu_src == 1'b1 & mem_to_reg == 1'b1 & reg_write == 1'b1;
        condition2 = ram_read == 1'b1 & write_enable == 1'b0 & beq == 1'b0 & bne == 1'b0;
        condition3 = alu_op == 2'b10 & jmp == 1'b0;
        if (condition1 & condition2 & condition3) $display("opcode 0 PASS");
        if (condition1 & condition2 & condition3) tests_passed = tests_passed + 5'b1;

        opcode = 4'b0001; #1; // opcode = 1 and case statement executed
        condition1 = dest_reg == 1'b0 & alu_src == 1'b1 & mem_to_reg == 1'b0 & reg_write == 1'b0;
        condition2 = ram_read == 1'b0 & write_enable == 1'b1 & beq == 1'b0 & bne == 1'b0;
        condition3 = alu_op == 2'b10 & jmp == 1'b0;
        if (condition1 & condition2 & condition3) $display("opcode 1 PASS");
        if (condition1 & condition2 & condition3) tests_passed = tests_passed + 5'b1;

        opcode = 4'b0010; #1;
        condition1 = dest_reg == 1'b1 & alu_src == 1'b0 & mem_to_reg == 1'b0 & reg_write == 1'b1;
        condition2 = ram_read == 1'b0 & write_enable == 1'b0 & beq == 1'b0 & bne == 1'b0;
        condition3 = alu_op == 2'b00 & jmp == 1'b0;
        if (condition1 & condition2 & condition3) $display("opcode 2 PASS");
        if (condition1 & condition2 & condition3) tests_passed = tests_passed + 5'b1;

        opcode = 4'b0011; #1;
        condition1 = dest_reg == 1'b1 & alu_src == 1'b0 & mem_to_reg == 1'b0 & reg_write == 1'b1;
        condition2 = ram_read == 1'b0 & write_enable == 1'b0 & beq == 1'b0 & bne == 1'b0;
        condition3 = alu_op == 2'b00 & jmp == 1'b0;
        if (condition1 & condition2 & condition3) $display("opcode 3 PASS");
        if (condition1 & condition2 & condition3) tests_passed = tests_passed + 5'b1;

        opcode = 4'b0100; #1;
        condition1 = dest_reg == 1'b1 & alu_src == 1'b0 & mem_to_reg == 1'b0 & reg_write == 1'b1;
        condition2 = ram_read == 1'b0 & write_enable == 1'b0 & beq == 1'b0 & bne == 1'b0;
        condition3 = alu_op == 2'b00 & jmp == 1'b0;
        if (condition1 & condition2 & condition3) $display("opcode 4 PASS");
        if (condition1 & condition2 & condition3) tests_passed = tests_passed + 5'b1;

        opcode = 4'b0101; #1;
        condition1 = dest_reg == 1'b1 & alu_src == 1'b0 & mem_to_reg == 1'b0 & reg_write == 1'b1;
        condition2 = ram_read == 1'b0 & write_enable == 1'b0 & beq == 1'b0 & bne == 1'b0;
        condition3 = alu_op == 2'b00 & jmp == 1'b0;
        if (condition1 & condition2 & condition3) $display("opcode 5 PASS");
        if (condition1 & condition2 & condition3) tests_passed = tests_passed + 5'b1;

        opcode = 4'b0110; #1;
        condition1 = dest_reg == 1'b1 & alu_src == 1'b0 & mem_to_reg == 1'b0 & reg_write == 1'b1;
        condition2 = ram_read == 1'b0 & write_enable == 1'b0 & beq == 1'b0 & bne == 1'b0;
        condition3 = alu_op == 2'b00 & jmp == 1'b0;
        if (condition1 & condition2 & condition3) $display("opcode 6 PASS");
        if (condition1 & condition2 & condition3) tests_passed = tests_passed + 5'b1;

        opcode = 4'b0111; #1;
        condition1 = dest_reg == 1'b1 & alu_src == 1'b0 & mem_to_reg == 1'b0 & reg_write == 1'b1;
        condition2 = ram_read == 1'b0 & write_enable == 1'b0 & beq == 1'b0 & bne == 1'b0;
        condition3 = alu_op == 2'b00 & jmp == 1'b0;
        if (condition1 & condition2 & condition3) $display("opcode 7 PASS");
        if (condition1 & condition2 & condition3) tests_passed = tests_passed + 5'b1;

        opcode = 4'b1000; #1;
        condition1 = dest_reg == 1'b1 & alu_src == 1'b0 & mem_to_reg == 1'b0 & reg_write == 1'b1;
        condition2 = ram_read == 1'b0 & write_enable == 1'b0 & beq == 1'b0 & bne == 1'b0;
        condition3 = alu_op == 2'b00 & jmp == 1'b0;
        if (condition1 & condition2 & condition3) $display("opcode 8 PASS");
        if (condition1 & condition2 & condition3) tests_passed = tests_passed + 5'b1;

        opcode = 4'b1001; #1;
        condition1 = dest_reg == 1'b1 & alu_src == 1'b0 & mem_to_reg == 1'b0 & reg_write == 1'b1;
        condition2 = ram_read == 1'b0 & write_enable == 1'b0 & beq == 1'b0 & bne == 1'b0;
        condition3 = alu_op == 2'b00 & jmp == 1'b0;
        if (condition1 & condition2 & condition3) $display("opcode 9 PASS");
        if (condition1 & condition2 & condition3) tests_passed = tests_passed + 5'b1;

        opcode = 4'b1010; #1; // default case
        condition1 = dest_reg == 1'b1 & alu_src == 1'b0 & mem_to_reg == 1'b0 & reg_write == 1'b1;
        condition2 = ram_read == 1'b0 & write_enable == 1'b0 & beq == 1'b0 & bne == 1'b0;
        condition3 = alu_op == 2'b00 & jmp == 1'b0;
        if (condition1 & condition2 & condition3) $display("opcode X PASS (3rd time 10)");
        if (condition1 & condition2 & condition3) tests_passed = tests_passed + 5'b1;
        
        opcode = 4'b1011; #1; // default case
        condition1 = dest_reg == 1'b0 & alu_src == 1'b0 & mem_to_reg == 1'b0 & reg_write == 1'b0;
        condition2 = ram_read == 1'b0 & write_enable == 1'b0 & beq == 1'b1 & bne == 1'b0;
        condition3 = alu_op == 2'b01 & jmp == 1'b0;
        if (condition1 & condition2 & condition3) $display("opcode 11 PASS");
        if (condition1 & condition2 & condition3) tests_passed = tests_passed + 5'b1;

        opcode = 4'b1100; #1; // default case
        condition1 = dest_reg == 1'b0 & alu_src == 1'b0 & mem_to_reg == 1'b0 & reg_write == 1'b0;
        condition2 = ram_read == 1'b0 & write_enable == 1'b0 & beq == 1'b0 & bne == 1'b1;
        condition3 = alu_op == 2'b01 & jmp == 1'b0;
        if (condition1 & condition2 & condition3) $display("opcode 12 PASS");
        if (condition1 & condition2 & condition3) tests_passed = tests_passed + 5'b1;

        opcode = 4'b1101; #1; // default case
        condition1 = dest_reg == 1'b0 & alu_src == 1'b0 & mem_to_reg == 1'b0 & reg_write == 1'b0;
        condition2 = ram_read == 1'b0 & write_enable == 1'b0 & beq == 1'b0 & bne == 1'b0;
        condition3 = alu_op == 2'b00 & jmp == 1'b1;
        if (condition1 & condition2 & condition3) $display("opcode 13 PASS");
        if (condition1 & condition2 & condition3) tests_passed = tests_passed + 5'b1;

        opcode = 4'b1110; #1; // default case
        condition1 = dest_reg == 1'b1 & alu_src == 1'b0 & mem_to_reg == 1'b0 & reg_write == 1'b1;
        condition2 = ram_read == 1'b0 & write_enable == 1'b0 & beq == 1'b0 & bne == 1'b0;
        condition3 = alu_op == 2'b00 & jmp == 1'b0;
        if (condition1 & condition2 & condition3) $display("opcode X PASS (4th time 14)");
        if (condition1 & condition2 & condition3) tests_passed = tests_passed + 5'b1;

        opcode = 4'b1010; #1; // default case
        condition1 = dest_reg == 1'b1 & alu_src == 1'b0 & mem_to_reg == 1'b0 & reg_write == 1'b1;
        condition2 = ram_read == 1'b0 & write_enable == 1'b0 & beq == 1'b0 & bne == 1'b0;
        condition3 = alu_op == 2'b00 & jmp == 1'b0;
        if (condition1 & condition2 & condition3) $display("opcode X PASS (5th time 15)");
        if (condition1 & condition2 & condition3) tests_passed = tests_passed + 5'b1;

        if (tests_passed == 5'b10010) $display("\nALL TESTS PASSED");
        else $display("TESTS FAILED");

        $finish;
        
    end // end stimuli

    initial
    begin
        // display timing and vars to the monitor
    end

endmodule