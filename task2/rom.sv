module rom (
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

  // Assign ROM values to outputs based on addresses
  assign data1 = rom_data[addr1];
  assign data2 = rom_data[addr2];

endmodule
