`timescale 1ns/1ps // define timescale 1 ns and resolution 1 ps = 0.001 ns

`include "pc.sv" // include DUT = device under test

module pc_tb; // testbench for testing the reg-file.sv Register File module - testbench has no I/O

    // define internal vars used in the testbench
    logic clk;
    logic [15:0] pc_count, pc_next, pc_branch;

    pc dut (clk, pc_next, pc_count, pc_branch); // define the pc.sv as DUT w its I/O

    always // always executes this loop
    begin // initiate CLK signal
        clk = 1; #10; clk = 0; #10; // 10 ns interval and then CLK changes between high/low
    end // define clk signal as square wave with period 20 ns

    initial // single-pass code block initialisation
    begin
        $dumpfile("pc_tb.vcd"); /* dump var changes of the testbench file 
                                  onto this Variable Dump Changes (vcd) file */
        $dumpvars(0, pc_tb);   /* Specifies to dump into VCD the lvl 0 file (i.e. top-level file) 
                                  w module name pc_tb */
  
        // testbench applies each address and sees that the output of the ROM read is correct
        
        #10; // pc_next ambiguous for t 0-10 ns so output pc should also be ambiguous x
        if (pc_count != 16'bx) $display("ERROR: pc_count should be x at t = 10 ns");
        pc_next = 0;
        #40; // pc_next is now 0 so pc_count should be 0 and pc_branch = pc_count+2
        if (pc_count != 0) $display("ERROR: pc_count should be 0 at t = 50 ns");
        if (pc_branch != 16'd2) $display("ERROR: pc_branch should be 2 at t = 50 ns");
        pc_next = 1;
        #20;
        if (pc_count != 1) $display("ERROR: pc_count should be 1 at t = 70 ns");
        if (pc_branch != 16'd3) $display("ERROR: pc_branch should be 3 at t = 70 ns");
        pc_next = 5;
        #20;
        if (pc_count != 5) $display("ERROR: pc_count should be 5 at t = 90 ns");
        if (pc_branch != 16'd7) $display("ERROR: pc_branch should be 7 at t = 90 ns");
        
        #10; $finish;
        
    end // end stimuli

    initial
    begin
        $monitor("t = %2d, clk = %1b, PCnext = %1d || PC = %1d, PCbranch = %1d ||", $time, clk, pc_next, pc_count, pc_branch);
        // display timing and vars to the monitor
    end

endmodule
