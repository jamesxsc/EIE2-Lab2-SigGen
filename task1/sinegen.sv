module sinegen #(
    parameter WIDTH = 8
)(
    // interface signals
    input logic clk,
    input logic en,
    input logic rst,
    input logic [WIDTH-1:0] freq,
    output logic [WIDTH-1:0] data
);

// private signals
logic [WIDTH-1:0] count;

// override parameters to width of mem file
rom #(
    .ADDR_WIDTH(WIDTH),
    .DATA_WIDTH(WIDTH)
) sine (
    .clk(clk),
    .en(en),
    .addr(count),
    .data(data)
);

divcounter #(
    .WIDTH(WIDTH)
) counter (
    .clk(clk),
    .count(count),
    .skip(freq),
    .en(en),
    .rst(rst)
);

endmodule: sinegen

