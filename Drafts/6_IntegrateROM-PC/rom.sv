module rom(input logic [7:0] address,
            output logic [15:0] data_out); // defines I/O

    // rom == InstrMem (instruction memory)

    logic [15:0] data_ROM [0:255]; // stores 256 words of size 16-bits 
    // -> 16-bit instr's = 16-bit system
    // the address is 8-bit wide

    initial
    $readmemh("romfile.txt", data_ROM);
        // reads datarom data from rom.txt file that has the 256 16-bit
        // words stored in HEX form
        
        // romfile.txt file contains the INSTRUCTIONS -> program to execute
        
    assign data_out = data_ROM[address];
        // the 8-bit address indicates 1 of 2^8 = 256 possible stored words

endmodule