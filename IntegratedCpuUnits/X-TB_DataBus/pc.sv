module pc(input logic clk, /* pc counters updated on rising clk edge */
          input logic [15:0] pc_next, /* next pc value -- pc_next = pc_count + 1 unless there is branching */
          output logic [15:0] pc_count, pc_branch); /* pc_count for base pc counter, pc_branch for BNE, BEQ */
          // define I/O

    initial begin
        pc_count <= 0; // initialize pc_count to 0
    end

    always_ff @(posedge clk) // update pc on rising clk edge
    begin
        pc_count <= pc_next;
    end

    assign pc_branch = pc_count + 16'b10; // pc_branch = pc_count + 2

endmodule