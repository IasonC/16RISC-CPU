module pc(input logic clk, reset,
            output logic [7:0] pc_count); // define I/O

    always_ff @(posedge clk) // update pc on rising clk edge
    begin
        if (reset) pc_count <= 8'b0; // active-high reset
        else pc_count <= pc_count + 1;
    end

endmodule