module counter #(
    parameter WIDTH = 8
)(
    input logic en,
    input logic rst,
    input logic clk,
    output logic [WIDTH-1:0] count
);

always_ff @(posedge clk) begin
    if (en) begin
        if (rst)
            count <= 0;
        else
            count <= count + 1;
    end
end


endmodule: counter

