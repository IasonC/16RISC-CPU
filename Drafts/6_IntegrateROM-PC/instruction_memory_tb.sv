`timescale 1ns/1ps // define timescale 1 ns and resolution 1 ps = 0.001 ns

`include "instruction_memory.sv" // include DUT = device under test

module instruction_memory_tb; // testbench for testing the reg-file.sv Register File module - testbench has no I/O

    // define internal vars used in the testbench
    logic clk, reset;
    logic [23:0] instr;
    logic [7:0] pc_count;

    instruction_memory dut (clk, reset, instr); // define the pc.sv as DUT w its I/O

    always // always executes this loop
    begin // initiate CLK signal
        clk = 1; #10; clk = 0; #10; // 10 ns interval and then CLK changes between high/low
    end // define clk signal as square wave with period 20 ns

    initial // single-pass code block initialisation
    begin
        $dumpfile("instruction_memory_tb.vcd"); /* dump var changes of the testbench file 
                                  onto this Variable Dump Changes (vcd) file */
        $dumpvars(0, instruction_memory_tb);   /* Specifies to dump into VCD the lvl 0 file (i.e. top-level file) 
                                  w module name pc_tb */
  
        // testbench applies each address and sees that the output of the ROM read is correct
        
        // reset ambiguous for t 0-10 ns so output pc should also be ambiguous x

        #10;
        reset = 0;
        #40; // PC not updated since PC has not been initialised to 0 yet by reset = 1
        reset = 1; // active high reset -> PC initialised to 0
        // in 10 ns, i.e. at 120 ns, PC should be reset to 0
        #60; // since reset is asserted, PC does not update by 1 here
        reset = 0; // reset de-asserted so we can increment PC now
        #120; // PC should increment 6 times up to 110
        reset = 1; // PC reset to 0 again
        #20; // PC not incremented
        
        #10; $finish;
        
    end // end stimuli

    initial
    begin
        $monitor("t = %3d, clk = %b, reset = %b || Instr = %h ||", $time, clk, reset, instr);
        // display timing and vars to the monitor
    end

endmodule

