module alu(input logic [15:0] a,
            input logic [15:0] b,
            input logic [2:0] ALUControl,
            output logic [15:0] ALUResult,
            output logic zero); // define I/O
    
    always_comb // combinational block
        case(ALUControl) // define case blocks to execute specific command
            3'b000 : ALUResult = a + b; // addition if ALUResult is 0
            3'b001 : ALUResult = a - b; // subtraction if ALUResult is 1
            3'b010 : ALUResult = ~a; // logical NOT gate if ALUResult is 2
            3'b011 : ALUResult = a << b; // bitwise leftshift if ALUResult is 3
            3'b100 : ALUResult = a >> b; // bitwise rightshift if ALUResult is 4
            3'b101 : ALUResult = a & b; // logical AND if ALUResult is 5
            3'b110 : ALUResult = a | b; // logical OR if ALUResult is 6
            3'b111 : ALUResult = (a<b) ? 16'b1 : 16'b0; // logical less than if ALUResult is 7
            default: ALUResult = a + b; // if not from above cases, output a+b default operation
        endcase

    assign zero = (ALUResult == 0) ? 1'b1 : 1'b0; // if ALUResult is 0, output 1 else output 0 in zero var

endmodule