module rom #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 8
)(
    input logic clk,
    input logic en,
    input logic [ADDR_WIDTH-1:0] addr,
    output logic [DATA_WIDTH-1:0] data
);
    logic [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH - 1:0];

    initial begin
        $display("Loading ROM...");
        $readmemh("sinerom.mem", mem);
    end

    always_ff @(posedge clk) begin
        if (en)
            data <= mem[addr];
    end

endmodule: rom
