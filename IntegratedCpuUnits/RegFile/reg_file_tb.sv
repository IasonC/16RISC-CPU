`timescale 1ns/1ps // define timescale 1 ns and resolution 1 ps = 0.001 ns

`include "reg_file.sv" // include DUT = device under test

module reg_file_tb; // testbench for testing the reg-file.sv Register File module - testbench has no I/O

    // define internal vars used in the testbench
    logic [3:0] RA1, RA2, WA;
    logic [15:0] data_in;
    logic clk, reset, write_enable;
    logic [15:0] data_out1, data_out2;

    reg_file dut ({RA1[3:0]}, {RA2[3:0]}, {WA[3:0]}, {data_in[15:0]}, 
        clk, reset, write_enable, {data_out1[15:0]}, {data_out2[15:0]}); // define the reg_file.sv as DUT w its I/O
    
    always // always executes this loop
    begin
        clk = 1; #10; clk = 0; #10; // 10 ns interval and then CLK changes between high/low
    end // define clk signal as square wave with period 20 ns

    // Self-checking testbench:
    initial // single-pass code block initialisation
    begin
        $dumpfile("reg_file_tb.vcd"); /* dump var changes of the testbench file 
                                  onto this Variable Dump Changes (vcd) file */
        $dumpvars(0, reg_file_tb);   /* Specifies to dump into VCD the lvl 0 file (i.e. top-level file) 
                                  w module name reg_file_tb */
  
        write_enable = 0;
        data_in[15:0] = 16'b1000101000110111; // a random data write package
        WA[3:0] = 4'b1000; // random register 4-bit address -- Enable deasserted so data_in will not save yet
        #10; // 10 - clk = 0
        RA1[3:0] = 4'b1000; // trying to read from WA address (data_out1 = X since nothing saved)
        RA2[3:0] = 4'b1111; // trying to read from other register that also has nothing stored -> data_out2 = X
        if (data_out1 != 16'bx || data_out2 != 16'bx) $display("Error - write to reg 8 & 15 with write_enable = 0");
        #10; // 20  - clk = 1
        write_enable = 1; // should save 16'b1000101000110111 into the registers now
        WA[3:0] = 4'b1000; // save data_in = 10001010 into register 8 = 1000_2
        RA1[3:0] = 4'b1000; // read from this file
        if (data_out1 != data_in) $display("Error - incorrect write to reg 8");
        #10; // 30 - clk = 0
        data_in[15:0] = 16'b1111010010000110; // another random word
        WA[3:0] = 4'b1111; // now save data_in = 1111010010000110 into register 15 = 1111_2
        RA2[3:0] = 4'b1111; // read from this register 15 -> should get data_out2 = 1111010010000110
        if (data_out1 != 16'bx) $display("Error - incorrect write to reg 15");
            // as CLK deasserted so nothing written even if write_enable = 1
        #10; // 40 - clk = 1
        RA1[3:0] = 4'b0000; // try to read from register 0 -> data_out1 = X as nothing has been saved here
        RA2[3:0] = 4'b0001; // try to read from register 1 -> data_out2 = X as nothing has been saved here
        if (data_out1 != 16'bx || data_out2 != 16'bx) $display("Error - read empty reg 0 & 1");
        #10; // 50 - clk = 0
        data_in[15:0] = 16'b0000000100000100; // another random package
        write_enable = 0; // cannot save data_in into registers anymore
        WA[3:0] = 4'b1111; // does not save to reg 15
        RA1[3:0] = 4'b1111; // last write did not save so data_out1 still remains 1111010010000110 at register 15
        if (data_out1 != 16'b1111010000000100) $display("Error - write to reg 15 with write_enable = 0");
        RA2[3:0] = 4'b0101; // reads another random register - data_out2 = X as nothing saved here
        if (data_out2 != 16'bx) $display("Error - incorrect read from empty reg 5");
        #10; // 60 - clk = 1
        write_enable = 1;
        data_in[15:0] = 16'b1000000011010010; // another word
        WA[3:0] = 4'b1000;
        RA1[3:0] = 4'b1000;
        #10; // 70 - clk = 0
        WA[3:0] = 4'b1111;
        RA2[3:0] = 4'b1111; // data_out1 = data_out2 = 1000000011010010
        if (data_out1 != data_in || data_out2 != data_in) $display("Error - incorrect write to reg 8 & 15");
        #10; // 80 - clk = 1
        reset = 0;
        RA1[3:0] = 4'b1000;
        RA2[3:0] = 4'b1111;
        #10; // 90 - clk = 0
        reset = 1;
        RA1[3:0] = 4'b1000;
        RA2[3:0] = 4'b1111; // test effect of reset enabled on the regiesters
        
        #10; $finish;
        
    end // end stimuli

    initial
    begin
        $monitor("t = %3d, RA1 = %b | RA2 = %b | WA = %b | clk = %b | reset = %b | \
write_enable = %b || data_in = %b | data_out1 = %b | \
data_out2 = %b", $time, RA1, RA2, WA, clk, reset, write_enable, data_in, data_out1, data_out2);
        // display timing and vars to the monitor
    end

endmodule

