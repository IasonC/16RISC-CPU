`timescale 1ns/1ps // define timescale 1 ns and resolution 1 ps = 0.001 ns

`include "alu_control.sv" // include DUT = device under test

module alu_control_tb; // testbench for testing the alu_control.sv ALU module - testbench has no I/O

    logic [1:0] alu_op;
    logic [3:0] opcode;
    logic [2:0] alu_ctrl; // define internal vars used in the testbench
    alu_control dut (alu_op, opcode, alu_ctrl); // define the alu_control.sv as DUT (named locally) w its I/O

    initial // single-pass code block initialisation
    begin
        $dumpfile("alu_control_tb.vcd"); /* dump var changes of the testbench file 
                                  onto this Variable Dump Changes (vcd) file */
        $dumpvars(0, alu_control_tb);    /* Specifies to dump into VCD the lvl 0 file (i.e. top-level file) 
                                  w module name alu_tb */

        alu_op[1:0] = 2'b01; opcode[3:0] = 4'b0101; 
        #10; if (alu_ctrl != 3'b001) $display("BEQ NEQ Error");
        opcode[3:0] = 4'b1011; // another random opcode -- since alu_op is 01 the opcode doesn't matter
        #10; if (alu_ctrl != 3'b001) $display("BEQ NEQ Error");
        alu_op[1:0] = 2'b10; // now switch to LW SW operations -- opcode still does not matter
        #10; if (alu_ctrl != 3'b000) $display("LW SW Error");
        alu_op[1:0] = 2'b11; // not defined in the instruction set -> triggers default case ALU AND operation
        #10; if (alu_ctrl != 3'b000) $display("ALU Default Error");
        alu_op[1:0] = 2'b00; // alu_op for normal Data Processing instrs. Now opcode matters
        #10; if (alu_ctrl != 3'b000) $display("ALU Default Error"); // opcode not defined in istr set so trigger Default case
        opcode[3:0] = 4'b0011; // opcode for SUB
        #10; if (alu_ctrl != 3'b001) $display("ALU SUB Error");
        opcode[3:0] = 4'b0111; // opcode for AND
        #10; if (alu_ctrl != 3'b101) $display("ALU AND Error");
        
    end // end stimuli

    initial
    begin
        $monitor("t = %2d, alu_op = %b | opcode = %b | alu_ctrl = %2b ", $time, alu_op, opcode, alu_ctrl);
        // display timing and vars a, b, ALUResult to the monitor
    end

endmodule