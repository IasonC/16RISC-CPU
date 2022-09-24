`timescale 1ns/1ps // define timescale 1 ns and resolution 1 ps = 0.001 ns

`include "ram.sv" // include DUT = device under test

module ram_tb; // testbench for testing the ram.sv RAM module - testbench has no I/O

    // define internal vars used in the testbench
    logic clk, write_enable, ram_read;
    logic [7:0] address;
    logic [15:0] write_data, data_out;

    ram dut (clk, write_enable, ram_read, address, write_data, data_out);
    // define the ram.sv as DUT w its I/O

    // initialise clock signal
    always // always executes this loop
    begin
        clk = 1; #10; clk = 0; #10; // 10 ns interval and then CLK changes between high/low
    end // define clk signal as square wave with period 20 ns

    // Self-checking testbench:
    initial // single-pass code block initialisation
    begin
        $dumpfile("ram_tb.vcd"); /* dump var changes of the testbench file 
                                  onto this Variable Dump Changes (vcd) file */
        $dumpvars(0, ram_tb);   /* Specifies to dump into VCD the lvl 0 file (i.e. top-level file) 
                                  w module name rom_tb */

        ram_read = 1; // read from RAM
        write_enable = 1; // enable writing to RAM
        address = 0;
        #5; if (data_out != 16'bx) $display("Error - ROM address 0, %b", data_out); // nothing stored in RAM yet

        #10; // clk = 0 -> no writing yet
        write_data = 16'b0100000000000010; // write to RAM random package
        if (data_out != 16'bx) $display("Error - ROM address 0, %b", data_out); // nothing stored in RAM yet

        #10; // clk = 1 -> now writing
        if (data_out != 16'b0100000000000010) $display("Error - ROM address 0, %b", data_out); // wrong data stored in RAM

        address = 1;
        #20; if (data_out != 16'bx) $display("Error - ROM address 1");

        #10; ram_read = 1'b0; write_data = 16'b0; #5;
        if (data_out != 16'b0) $display("Error - ROM address 1");

        #20; address = 0;
        if (data_out != 16'b0) $display("Error - ROM address 1");
        
        #10; $finish;
        
    end // end stimuli

    initial
    begin
        $monitor("t = %3d, RAM address = %b, RAM Data Out = %b", $time, address, data_out);
        // display timing and vars to the monitor
    end

endmodule