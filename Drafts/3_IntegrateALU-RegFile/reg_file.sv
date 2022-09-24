module reg_file(input logic [3:0] RA1, RA2, WA, // addresses
                input logic [7:0] data_in, // data to write
                input logic clk, reset, write_enable, // control signals
                output logic [7:0] data_out1, data_out2); // data to read
                // define I/O

    logic [7:0] rf [0:15]; // initialise register file of 16 8-bit registers
        // so there are 16 regs w 8-bit address each
    
    assign data_out1 = rf[RA1]; // read from register at address RA1 in reg file
    assign data_out2 = rf[RA2]; // read from reg at address RA2 in register file
    
    always_ff @ (posedge clk) // loop for constant assignment on rising CLK edge
        if (write_enable) 
        rf[WA] <= data_in; // write data saved to register w address WA

endmodule