module ram(input logic clk, write_enable, ram_read,
           input logic [7:0] access_address,
           input logic [15:0] write_data,
           output logic [15:0] data_out); // defines I/O

    // ram will store program vars & results during execution

    logic [15:0] data_RAM [0:7]; // RAM with 256 memory locations, each stores 16 bits
    // the address is 8-bit wide
    int f; // file descriptor for the RAM file
    int i; // for loop to write in file

    initial
    $readmemh("ram_data.txt", data_RAM); // read in the data from the file
        // ram_data.txt file contains the executed program vars & results
        
    always @ (posedge clk) begin
        if (write_enable) begin
            data_RAM[access_address] <= write_data; // write to the RAM at given address
            f = $fopen("ram_data.txt", "w"); // open the file for writing
            for (i = 0; i < 256; i++) begin
                $fwrite(f, "%h \n", data_RAM[i]); // write the data to the file
            end
            $fclose(f); // close the file
        end
    end
    assign data_out = (ram_read==1) ? data_RAM[access_address] : 16'b0; // read from the RAM at given address
        // if ram_read == 1'b1, then data_out is the data at access_address; else, data_out is 0

endmodule