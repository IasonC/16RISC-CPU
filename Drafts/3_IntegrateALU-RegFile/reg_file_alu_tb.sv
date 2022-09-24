`timescale 1ns/1ps // define timescale 1 ns and resolution 1 ps = 0.001 ns

`include "reg_file_alu.sv" // include DUT = device under test
//`include "reg_file.sv" // includes Register File
//`include "alu.sv" // includes ALU

module reg_file_alu_tb; // testbench for testing the reg_file_alu.sv Register File module - testbench has no I/O

    // define internal vars used in the testbench
    logic [3:0] RA1, RA2, WA;
    logic [7:0] external_data_in;
    logic [1:0] ALUControl;
    logic clk, RegWrite, ALUSrc;
    logic [7:0] ALUResult;

    reg_file_alu dut (RA1, RA2, WA, external_data_in, ALUControl, clk, RegWrite, ALUSrc, ALUResult); // define the reg_file.sv as DUT w its I/O
    
    // initialise clock signal
    always // always executes this loop
    begin
        clk = 1; #10; clk = 0; #10; // 10 ns interval and then CLK changes between high/low
    end // define clk signal as square wave with period 20 ns

    // Self-checking testbench:
    initial // single-pass code block initialisation
    begin
        $dumpfile("reg_file_alu_tb.vcd"); /* dump var changes of the testbench file 
                                  onto this Variable Dump Changes (vcd) file */
        $dumpvars(0, reg_file_alu_tb);   /* Specifies to dump into VCD the lvl 0 file (i.e. top-level file) 
                                  w module name reg_file_tb */

            // t0, clk = 1
        external_data_in = 0; ALUSrc = 1; ALUControl = 0; // AND operation in ALU with ext_data and RegFile SrcA
        RegWrite = 1; // allow writing
        WA = 15; // write ALUResult = 0 into the 15th register (i.e. 1111 address) -> written as CLK = 1 now
        if (ALUResult != 8'b0) $display("Initial Error writing 0 to ALUResult");

        #25; // t25, clk = 1
        ALUControl = 1; // OR ALU
        RA1 = 15; // SrcA = WD3 = ALUResult = 0, SrcB = external_data_in
        external_data_in = 8'b11111111;
        #1;
        if (ALUResult != external_data_in) $display("%b", ALUResult);

        #19;// t45, clk = 1
        ALUControl = 0; // AND
        external_data_in = 8'b11001110;
        #1;
        if (ALUResult != (8'b11111111 & 8'b11001110)) $display("Error assigning to reg 15");

        #8; // t54, clk = 0
        external_data_in = 8'b00000001;
            // ALUResult = (8'b11111111 & 8'b11001110) & 8'b00000001
            // BUT since clk = 0 this is not written into reg 15
        #1; // t55
        external_data_in = 8'b00000000; // all zeros
        ALUControl = 1; 
            // OR between ALUResult = ((8'b11111111 & 8'b11001110) & 8'b00000001) and 8'b00000000
        #1;
        if (ALUResult != (8'b11111111)) $display("Error - reg 15 updated on clk = 0, %b", ALUResult);
            // reg 15 did not retain its value
        
        #19; // t75
        external_data_in = 0;
        ALUControl = 0;
        WA = 2; // save 0 to reg 2 at t = 80 when clk goes 0->1 rising edge
        #1;
        if (ALUResult != (8'b00000000)) $display("Error - reg 2 not updated with zeros");
        
        #9; // t85
        RA1 = 2;
        ALUControl = 1; // OR
        external_data_in = 8'b11011100; // will save into Reg 2 and update it at t = 100 ns
        #1;
        if (ALUResult != (8'b11011100)) $display("Error - reg 2 not updated with 11011100");

        #19; // 105
        WA = 15;
        RA1 = 15;
        external_data_in = 8'b01010110; // will save into Reg 15 and update it at t = 120 ns
        ALUControl = 0; // AND -> saves 01010110 & 11111111 = 8'b01010110
        #1;
        if (ALUResult != (8'b01010110)) $display("Error - reg 15 not updated with 01010110");

        #19; // 125
        RA2 = 15; // storing 11011100
        RA1 = 2; // storing 01010110

        ALUSrc = 0; // so the ALU tests the 4 operations between 11011100 and 01010110
        #1;
        ALUControl = 0; // AND
        #1; if (ALUResult != 8'b01010100) $display("Error - ALU Operation 00");
        $display("ALU 00: %b", ALUResult);
        #1;
        ALUControl = 1; // OR
        #1; if (ALUResult != 8'b11011110) $display("Error - ALU Operation 01");
        $display("ALU 01: %b", ALUResult);
        #1;
        ALUControl = 2; // ADD
        #1; if (ALUResult != 8'b00110010) $display("Error - ALU Operation 10");
        $display("ALU 10: %b", ALUResult);
        #1;
        ALUControl = 3; // SUBTRACT
        #1; if (ALUResult != 8'b10000110) $display("Error - ALU Operation 11");
        $display("ALU 11: %b", ALUResult);

        // t132
        WA = 6; ALUSrc = 1; ALUControl = 0; external_data_in = 8'b00000000;
        // clk rising edge at 140 ns
        
        #10; // t142 - clk has risen to +ve edge
        RA1 = 6; RegWrite = 0; // will not save into the register as RegWrite de-asserted
        ALUControl = 1; external_data_in = 8'b11111111; // will not save
        #20;
        external_data_in = 10101010; ALUControl = 0; // AND
        #1;
        if (ALUResult != 8'b00000000) $display("Error - Reg 6 updated while RegWrite = 0");
            // the result stored in reg 6 should still be 8'b0 as 8'b1 was not saved in the reg
            // so 10101010 AND 00000000 = 00000000

        #10; $finish;
        
    end // end stimuli

    initial
    begin
        $monitor("t = %3d, RA1=%d | RA2=%d | WA=%d | AC=%d | clk=%b | RW=%b | \
AS=%b || ED = %b | AR = %b\
", $time, RA1, RA2, WA, ALUControl, clk, RegWrite, ALUSrc, external_data_in, ALUResult);
        // display timing and vars to the monitor
    end

endmodule
