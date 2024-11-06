module sinegen (
    input  logic        clk,
    input  logic        rst,
    input  logic [7:0]  skip,      // Skip value for frequency control
    output logic [7:0]  data1,     // Output for sine wave
    output logic [7:0]  data2,      // Output for cosine (or phase-shifted sine)
    input logic  [7:0]  offset
);

    logic [7:0] addr1;     // Address for sine wave (frequency controlled)
    logic [7:0] addr2;     // Address for phase-shifted wave

    // Frequency division counter to control the address increment rate
    divcounter #(
        .WIDTH(8)
    ) div (
        .clk(clk),
        .rst(rst),
        .en(1'b1),
        .skip(skip),          // Skip value to control frequency
        .count(addr1)         // Output address for sine wave
    );

    // Calculate the second address with phase offset
    assign addr2 = addr1 + offset;

  rom
     u_rom (
        .clk(clk),
        .en1(1'b1),
        .en2(1'b1),
        .addr1(addr1),
        .addr2(addr2),
        .data1(data1),
        .data2(data2)
    );

endmodule
