`timescale 1ns/1ps // define timescale 1 ns and resolution 1 ps = 0.001 ns

`include "alu.sv" // include DUT = device under test

module alu_tb; // testbench for testing the alu.sv ALU module - testbench has no I/O

    logic [15:0] a, b, ALUResult;
    logic [2:0] ALUControl;    
    logic zero; // define internal vars used in the testbench
    alu dut ({a[15:0]}, {b[15:0]}, {ALUControl[2:0]}, {ALUResult[15:0]}, zero); // define the alu.sv as DUT (named locally) w its I/O

    initial // single-pass code block initialisation
    begin
        $dumpfile("alu_tb.vcd"); /* dump var changes of the testbench file 
                                  onto this Variable Dump Changes (vcd) file */
        $dumpvars(0, alu_tb);    /* Specifies to dump into VCD the lvl 0 file (i.e. top-level file) 
                                  w module name alu_tb */

        a[15:0] = 16'b0000000011011100; b[15:0] = 16'b0000000001010110; // output now should be 100110010
        // (ALUControl not yet provided so default ALU case - addition)
        #5; if (ALUResult != 16'b0000000100110010) $display("ALU testbench FAILED"); // check the result of the ALU
        #10;
        ALUControl[2:0] = 3'b000; // output should be ALUResult = 100110010 (TC addition), zero=0
        #5; if (ALUResult != 16'b0000000100110010) $display("ALU testbench FAILED"); // check the result of the ALU
        #10;
        ALUControl[2:0] = 3'b001; // output ALUResult = 10000110, zero=0
        #5; if (ALUResult != 16'b0000000010000110) $display("ALU testbench FAILED"); // check the result of the ALU
        #10;
        ALUControl[2:0] = 3'b010; // output ALUResult = 1111111100100011, zero=0
        #5; if (ALUResult != 16'b1111111100100011) $display("ALU testbench FAILED"); // check the result of the ALU
        #10;
        b[15:0] = 16'b0000000000000010;
        ALUControl[2:0] = 3'b011; // output ALUResult = 0000001101110000 (left shift by 2)
        #5; if (ALUResult != 16'b0000001101110000) $display("ALU testbench FAILED"); // check the result of the ALU
        #10;
        ALUControl[2:0] = 3'b100; // output ALUResult = 0000000000110111 (right shift by 2)
        #5; if (ALUResult != 16'b0000000000110111) $display("ALU testbench FAILED"); // check the result of the ALU
        #10;
        b[15:0] = 16'b0000000001010110; ALUControl[2:0] = 3'b101; // output ALUResult = 0000000001010100 (AND)
        #5; if (ALUResult != 16'b0000000001010100) $display("ALU testbench FAILED"); // check the result of the ALU
        #10;
        ALUControl[2:0] = 3'b110; // output ALUResult = 0000000011011110 (OR)
        #5; if (ALUResult != 16'b0000000011011110) $display("ALU testbench FAILED"); // check the result of the ALU
        #10;
        ALUControl[2:0] = 3'b111; // output ALUResult = 0 since a ~< b, zero = 1
        #5; if (ALUResult != 16'b0 || zero != 1'b1) $display("ALU testbench FAILED"); // check the result of the ALU
        #10;
        a[15:0] = 16'b0000000011111111; b[15:0] = 16'b0000000011111111; ALUControl[2:0] = 3'b001; // zero = 1
        #5; if (ALUResult != 16'b0 || zero != 1'b1) $display("ALU testbench FAILED"); // check the result of the ALU
        #10; $finish;
        
    end // end stimuli

    initial
    begin
        $monitor("t = %3d, a = %b | b = %b | ALUControl = %2b | ALUResult = %b | zero = %b", $time, a, b, ALUControl, ALUResult, zero);
        // display timing and vars a, b, ALUResult to the monitor
    end

endmodule