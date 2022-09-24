module alu(input logic [7:0] a,
            input logic [7:0] b,
            output logic [7:0] ALUResult,
            input logic [1:0] ALUControl); // define I/O
    
    always_comb // combinational block
        case(ALUControl) // define case blocks to execute specific command
            2'b00 : ALUResult = a & b; // logical AND if ALUResult is 00
            2'b01 : ALUResult = a | b; // logical OR if ALUResult is 01
            2'b10 : ALUResult = a + b; // addition if ALUResult is 10
            2'b11 : ALUResult = a - b; // subtraction if ALUResult is 11
            default: ALUResult = 8'bx; // if not from above cases, output X
        endcase

endmodule