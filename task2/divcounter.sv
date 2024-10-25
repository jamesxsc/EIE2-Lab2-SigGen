module divcounter #(
    parameter WIDTH = 8
)(
    input  logic             clk,
    input  logic             rst,
    input  logic             en,
    input  logic [WIDTH-1:0] skip,     // Skip value for frequency division
    output logic [WIDTH-1:0] count     // Output count
);

    logic [WIDTH-1:0] internalcount;    // Internal fast counter
    logic internalen;                   // Internal enable for output counter

    // Fast counter instance
    counter #(
        .WIDTH(WIDTH)
    ) fast (
        .clk(clk),
        .count(internalcount),
        .en(en),
        .rst(rst)
    );

    // Output counter instance with internal enable
    counter #(
        .WIDTH(WIDTH)
    ) out (
        .clk(clk),
        .count(count),
        .en(internalen),
        .rst(rst)
    );

    // Enable the output counter when internalcount reaches the skip value
    always_comb begin
        internalen = (internalcount % skip == 0); // Enable every "skip" cycles
    end

endmodule: divcounter
