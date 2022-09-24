module alu_control(input logic [1:0] alu_op, // indicates LW, SW and BEQ, BNQ operations
                   input logic [3:0] opcode, // opcode to indicate ALU operation in Data Processing instr's
                   output logic [2:0] alu_ctrl); // ALU control signal to choose the ALU operation corresponding to opcode

    logic [5:0] ALU_OpControl; // opcontrol for ALU
    assign ALU_OpControl = {alu_op, opcode}; // concatenate alu_op and opcode to get ALU_OpControl
        // alu_op and opcode are different signals in datapath but treated together for ALU so concatenated here

    always_comb begin
        casex (ALU_OpControl)
            6'b10xxxx: alu_ctrl = 3'b000; // LW, SW
            6'b01xxxx: alu_ctrl = 3'b001; // BEQ, BNQ
            6'b000010: alu_ctrl = 3'b000; // ADD
            6'b000011: alu_ctrl = 3'b001; // SUB
            6'b000100: alu_ctrl = 3'b010; // NOT
            6'b000101: alu_ctrl = 3'b011; // LSL
            6'b000110: alu_ctrl = 3'b100; // LSR
            6'b000111: alu_ctrl = 3'b101; // AND
            6'b001000: alu_ctrl = 3'b110; // OR
            6'b001001: alu_ctrl = 3'b111; // Logical Less Than
            default: alu_ctrl = 3'b000; // default is ADD
        endcase
    end
        
endmodule