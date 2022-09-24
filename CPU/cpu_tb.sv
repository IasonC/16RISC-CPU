`timescale 1ns/1ps // define timescale 1 ns and resolution 1 ps = 0.001 ns

`include "cpu.sv" // include DUT = device under test

module cpu_tb; // testbench for testing the risc_control.sv ROM module - testbench has no I/O

    // define CLK signal used in CPU testbench
    logic clk;
    always // always executes this loop
    begin // initiate CLK signal
        clk = 1; #10; clk = 0; #10; // 10 ns interval and then CLK changes between high/low
    end // define clk signal as square wave with period 20 ns

    cpu dut (clk);
    // define the cpu.sv as DUT w its I/O

    // Self-checking testbench:
    initial // single-pass code block initialisation
    begin
        #1000; // run CPU for 160 ns

        $finish;
        
    end // end stimuli

endmodule