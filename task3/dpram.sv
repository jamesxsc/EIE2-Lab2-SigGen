module dpram #(
    parameter ADDR_WIDTH = 9,
    parameter DATA_WIDTH = 8
)(
    input logic clk,
    input logic ren,
    input logic wen,
    input logic [ADDR_WIDTH-1:0] raddr,
    input logic [ADDR_WIDTH-1:0] waddr,
    input logic [DATA_WIDTH-1:0] win,
    output logic [DATA_WIDTH-1:0] rout
);

logic [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH-1:0];

always_ff @(posedge clk) begin
    if (ren) begin
        rout <= mem[raddr];
    end
    if (wen) begin
        mem[waddr] <= win;
    end
end

endmodule: dpram
