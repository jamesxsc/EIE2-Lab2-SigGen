module divcounter #(
    parameter WIDTH = 8
)(
    input logic clk,
    input logic rst,
    input logic en,
    input logic [WIDTH-1:0] skip,
    output logic [WIDTH-1:0] count
);

logic [WIDTH-1:0] internalcount;
logic internalen;

counter #(
    .WIDTH(WIDTH)
) fast (
    .clk(clk),
    .count(internalcount),
    .en(en),
    .rst(rst)
);

counter #(

) out (
    .clk(clk),
    .count(count),
    .en(internalen),
    .rst(rst)
);

always_comb begin
    // slightly different to the lecture way
    internalen <= (internalcount % skip) == 0;
end

endmodule: divcounter
