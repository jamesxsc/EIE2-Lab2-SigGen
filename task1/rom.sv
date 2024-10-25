module rom #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 8
)(
    input logic clk,
    input logic en1,                         // Enable for port 1
    input logic en2,                         // Enable for port 2
    input logic [ADDR_WIDTH-1:0] addr1,      // Address for port 1
    input logic [ADDR_WIDTH-1:0] addr2,      // Address for port 2
    output logic [DATA_WIDTH-1:0] data1,     // Data output for port 1
    output logic [DATA_WIDTH-1:0] data2      // Data output for port 2
);

    logic [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH - 1:0]; // Memory array

    // Load ROM data from file during initialization
    initial begin
        $display("Loading ROM data from sinerom.mem...");
        $readmemh("sinerom.mem", mem);
    end

    // Output data1 for port 1 on clock edge if en1 is asserted
    always_ff @(posedge clk) begin
        if (en1)
            data1 <= mem[addr1];
    end

    // Output data2 for port 2 on clock edge if en2 is asserted
    always_ff @(posedge clk) begin
        if (en2)
            data2 <= mem[addr2];
    end

endmodule: rom
