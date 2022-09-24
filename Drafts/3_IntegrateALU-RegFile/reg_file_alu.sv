`include "reg_file.sv" // includes Register File
`include "alu.sv" // includes ALU

module reg_file_alu(input logic [3:0] RA1, RA2, WA,
                    input logic [7:0] external_data_in,
                    input logic [1:0] ALUControl,
                    input logic clk, RegWrite, ALUSrc,
                    output logic [7:0] ALUResult);
                    // define top-level I/O

    logic [7:0] SrcA; // data_out1 of RegFile -> goes to ALU
    logic [7:0] SrcB; // MUX output: data_out2 and external_data_in -> to ALU
    logic [7:0] SrcMux; // define internal var that is 2nd output of RegFile
    logic reset; // unused var but declared as it is an input for the RegFile

    reg_file reg_file(RA1, RA2, WA, ALUResult, clk, reset, RegWrite, SrcA, SrcMux);
        // define implementation of Reg File with correct vars

    assign SrcB = (ALUSrc) ? external_data_in : SrcMux;
        // multiplexer

    alu alu(SrcA, SrcB, ALUResult, ALUControl);
        // define implementation of ALU

endmodule