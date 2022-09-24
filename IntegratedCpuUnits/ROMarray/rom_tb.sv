`timescale 1ns/1ps // define timescale 1 ns and resolution 1 ps = 0.001 ns

`include "rom.sv" // include DUT = device under test

module rom_tb; // testbench for testing the rom.sv ROM module - testbench has no I/O

    // define internal vars used in the testbench
    logic [7:0] address;
    logic [15:0] data_out;

    rom dut (address, data_out); // define the rom.sv as DUT w its I/O

    // Self-checking testbench:
    initial // single-pass code block initialisation
    begin
        $dumpfile("rom_tb.vcd"); /* dump var changes of the testbench file 
                                  onto this Variable Dump Changes (vcd) file */
        $dumpvars(0, rom_tb);   /* Specifies to dump into VCD the lvl 0 file (i.e. top-level file) 
                                  w module name rom_tb */
  
        // testbench applies each address and sees that the output of the ROM read is correct
        address = 0; // address 0 should store 0110000100000000
        #1; if (data_out != 16'b0110000100000000) $display("Error - ROM address 0, %b", data_out);

        #9;
        address = 1; // address 1 should store 0100000000000001
        #1; if (data_out != 16'b0100000000000001) $display("Error - ROM address 1");

        #9;
        address = 2; // address 2 should store 0100000000000010
        #1; if (data_out != 16'b0100000000000010) $display("Error - ROM address 2");

        #9;
        address = 3; // address 3 should store 0001001000010011
        #1; if (data_out != 16'b0001001000010011) $display("Error - ROM address 3");

        #9;
        address = 4; // address 4 = 00000100_2 stores nothing -> x
        #10;
        address = 5;
        #10;
        address = 23;
        #10;
        address = 245;
        
        #10; $finish;
        
    end // end stimuli

    initial
    begin
        $monitor("t = %3d, ROM address = %b, ROM Data Out = %b", $time, address, data_out);
        // display timing and vars to the monitor
    end

endmodule