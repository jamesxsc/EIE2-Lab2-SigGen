module rom (

  input logic clk,
  input logic en1,                         // Enable for port 1
  input logic en2,                         // Enable for port 2
  input logic [7:0] addr1,  // First address input
  input logic [7:0] addr2,  // Second address input
  output logic [7:0] data1, // Output data for first port
  output logic [7:0] data2  // Output data for second port
);

  logic [7:0] rom_data[0:255]; // 256 x 8-bit ROM

  // Load ROM contents from memory file
  initial begin
    $readmemh("sinerom.mem", rom_data);
  end
    // Output data1 for port 1 on clock edge if en1 is asserted
    always_ff @(posedge clk) begin
        if (en1)
            data1 <= rom_data[addr1];
    end

    // Output data2 for port 2 on clock edge if en2 is asserted
    always_ff @(posedge clk) begin
        if (en2)
            data2 <= rom_data[addr2];
    end



endmodule
